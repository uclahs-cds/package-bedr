\name{bedr}
\alias{bedr}

\title{
Main bedtools wrapper function.
}
\description{
Main bedtools wrapper function.
}
\usage{
bedr(engine = "bedtools", 
	params = NULL,
	input = list(),
	method = NULL,
	tmpDir = NULL,
	deleteTmpDir = TRUE,
	outputDir = NULL,
	outputFile = NULL,
	check.chr = TRUE,
	check.zero.based = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	);

}

\arguments{
  \item{engine}{What analytical engine to use i.e. bedtools, bedops, tabix, unix}
  \item{params}{A string that includes all the extra parameters and arguments to the bedtools commmand.  For example if you wanted to do a left outer join you would specificy method as intersect and use params = c("-loj -header"). If you leave input and method as defaults then this is this string represents the full command.}
  \item{input}{A list of input items to be used by bedtools.  Each item should be named by its parameter name in bedtools for example input = list(a=xxx, b=yyy, i=zzz).  Items can be R objects or external files.  R objects need to be in bed format i.e. have chr, start, stop as the first three columns, or, have an position index as the first column or rowname i.e. chr1:100-1000.}
  \item{method}{What bedtools method.  This can be intersect, sort, merge etc.  See bedtools documentation for specifcis.}
  \item{tmpDir}{The directory to be used for writing files}
  \item{deleteTmpDir}{Should tmp files be deleted.  helpful for diagnostics.}
  \item{outputDir}{The output directory.  Only used if outputFile is specified.  It defaults to the current working directory.}
  \item{outputFile}{The name of the output file.  If this is specified the output will be sent to a file not an R object}
  \item{check.chr}{check for chr prefix}
  \item{check.zero.based}{check for zero based coordinates}
  \item{check.valid}{do all region integrity checks}
  \item{check.sort}{check if region is sorted}
  \item{check.merge}{check if region is  merged}
  \item{verbose}{Should messages be printed to screen.}
}
%\details{
%}
\value{
The output of command with some parsing to keep it consistent with the input. 

}
\author{
Daryl Waggott
}


\seealso{
iranges
}
\examples{
if (check_binary("bedtools")) {
set.seed(666)

index <- get_example_regions();
a <- index[[1]];
b <- index[[2]];

### check
is.a.valid  <- is_valid_region(a);
is.b.valid  <- is_valid_region(b);
a <- a[is.a.valid];
b <- b[is.b.valid];

### sort
is.sorted <- is_sorted_region(a);
a.sort1 <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
b.sort1 <- bedr(engine = "bedtools", input = list(i = b), method = "sort", params = "");
a.sort2 <- bedr(engine = "bedops",   input = list(i = a), method = "sort", params = "");

a.sort3 <- sort_region(a);
a.sort4 <- sort_region(a, engine = "unix", method = "natural");
a.sort5 <- sort_region(a, engine = "R", method = "natural");

### merge
is.merged <- is_merged_region(a.sort1);
a.merge1 <- bedr(engine = "bedtools", input = list(i = a.sort1), method = "merge", params = "");
b.merge1 <- bedr(engine = "bedtools", input = list(i = b.sort1), method = "merge", params = "");
a.merge2 <- bedr(engine = "bedops",   input = list(i = a.sort1), method = "merge", params = "");
# a.merge3 <- merge_region(a); this will throw an error b/c region is not sorted

### subtract
a.sub1 <- bedr(input = list(a = a.merge1, b = b.merge1), method = "subtract", params="");
a.sub2 <- subtract_region(a.merge1, b.merge1);

### in_region
is.region <- in_region(a.merge1, b.merge1);
#is.region <- a.merge1 \%in.region\% b.merge1

### intersect 
# note for bedtools its  recommended to sort_regions before intersect to allow for faster processing
# also if regions are not merged this can cause unexpected behaviour
a.int1 <- bedr(input = list(a = a, b = b), method = "intersect", params = "-loj");
a.int1 <- bedr(input = list(a = a.sort1, b = b.sort1), method="intersect",params ="-loj -sorted");
a.int2 <- bedr(input = list(a = a.merge1, b = b.merge1), method="intersect",params="-loj -sorted");
a.int3 <- join_region(a.merge1, b.merge1);

### multiple join
d <- get_random_regions(100, chr="chr1", sort = TRUE);
a.mult <- join_multiple_region(x = list(a.merge1,b.merge1,sort_region(d)));

### groupby 
# note the "g" column number is based on bed format i.e. first three columns chr, start, stop
# note the use of first, first, last on the region columns i.e. the union of the regions
# note currently missing values are note dealt with in bedtools.  also the 5th column is 
# assumed to be "score" and gets a default "-1" not a "."
#cnv.gene <- bedr(input = list(i=cnv.gene), method = "groupby", params = paste("-g 16 -c ", 
#paste(1:15, collapse = ","), " -o ", "first,first,last,", 
#paste(rep("sum",12), collapse = ","), sep = ""));

### example 1
###  workflow adding gene names to exome sequencing target file
# download refseq genes from ucsc or query biomart for ensemble gene names.  
#format them in basic bed format.
# sort, merge target
# sort, merge -nms target.  Overlapping genes/features get merged.  
#this may not be ideal if there are some really big features.
# intersect -loj target, genes.
# alternatively, do not merge the target and apply the merge after the intersect.  
#this will provide precision a the level of the exon.
}
}


\keyword{bedtools}
\keyword{bedops}
\keyword{tabix}
\keyword{region}
\keyword{interval}
\keyword{bed}
