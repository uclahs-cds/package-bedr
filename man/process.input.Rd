\name{process.input}
\alias{process.input}
\title{
process.input
}
\description{
process.input
}
\usage{
process.input(
	input, 
	tmpDir = NULL,
	include.names = TRUE, 
	check.zero.based = TRUE, 
	check.chr = TRUE, 
	check.valid = TRUE, 
	check.sort = TRUE, 
	check.merge = TRUE, 
	verbose = TRUE
	)
}
\arguments{
  \item{input}{regions input or a file in one of the standard formats. these are bed, vcf, gff, bam, sam, csv, tsv, txt}
  \item{tmpDir}{The directory to be used for writing files}
  \item{include.names}{should the names of the input files be included in the output}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checked for integerity}
  \item{check.sort}{should the region sorting be checked}
  \item{check.merge}{should overlapping regions be checked}
  \item{verbose}{messages and checks}
}
%\details{
%}
\value{
list of input files
}
%\references{
%}
\author{
Daryl Waggott
}

%\seealso{
%}

\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();
a <- index[[1]];
a <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
a.processed <- process.input(a, verbose = FALSE)

}
}
\keyword{input}
