\name{test.region.similarity}
\alias{test.region.similarity}
\title{
Compare sets of regions via jaccard and relative distance using permutation
}
\description{
Compare sets of regions via jaccard and relative distance using permutation to get an empirical p-value.
}
\usage{
test.region.similarity(
	x,
	y,
	n = 1000,
	stratify.by.chr = FALSE,
	species = "human",
	build = "hg19",
	mask.gaps = FALSE,
	mask.repeats = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	verbose = TRUE
	)
}
\arguments{
  \item{x}{first region to be compared. this is the region that is permuted}
  \item{y}{second region to be compared}
  \item{n}{the number of iterations to permute}
  \item{stratify.by.chr}{Should the permutation be happen separetely for each chromosome.  That is are chromosomes exchangeable.}
  \item{species}{species}
  \item{build}{the build of the reference}
  \item{mask.gaps}{should the gaps (Ns) in the human reference be ignored as potential start points.  This drammatically increases memory and run time but is more appropriate in almost all settings.  By default it's off.}
  \item{mask.repeats}{should the repeats from repeatMasker be ignored as potential start points.  This drammatically increases memory and run time but is more appropriate in almost all settings.  By default it's off.}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{verbose}{should log messages and checking take place}

}
\details{
Iteratively permutes intervals and recalculates jaccard and reldist statistics.
}
\value{
A list of results
}
\author{
Daryl Waggott
}
\examples{

if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];
b <- index[[2]];
a <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
b <- bedr(engine = "bedtools", input = list(i = b), method = "sort", params = "");

# a simple example
test.region.similarity(a, b, n = 8)

# note you can set the cores available to parallelize
options(cores = 4);
system.time(test.region.similarity(a, b, n = 8));

# a real example comparing the distribution of mRNA vs ncRNA genes in RefSeq
\dontrun{

# more core
options(cores = 8);

# load refgene
refgene <- query.ucsc("refGene")
refgene <- refgene[,c("chrom","txStart","txEnd","name","name2","strand")]

# only include canonical chr
chr <- paste0("chr", c(1:22,"X","Y")); 
refgene <- refgene[refgene$chrom %in% chr,]

# remove genes with multiple positions
duplicated.gene <- duplicated(refgene$name2) | duplicated(rev(refgene$name2));
refgene <- refgene[!duplicated.gene,];

# only select pr coding genes
refgene.nm <- refgene[grepl("^NM",refgene$name),];
# only select non protein coding rna genes	
refgene.nr <- refgene[grepl("^NR",refgene$name),];

# sort and merge
refgene.nm <- snm(refgene.nm,check.chr = FALSE);
refgene.nr <- snm(refgene.nr,check.chr = FALSE);

test.region.similarity(refgene.nm, refgene.nr, mask.unmapped = TRUE );

option(core = 1)
}

}

}
\keyword{ permute}
