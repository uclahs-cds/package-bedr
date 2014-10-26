\name{grow.region}
\alias{grow.region}

\title{
Get adjacent flanks from regions
}
\description{

Get adjacent flanks from regions
}
\usage{
grow.region(
	x,
	n.add = NULL,
	start.add = NULL,
	end.add = NULL,
	species = "human",
	build = "hg19",
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)

}

\arguments{
  \item{x}{ a object region object or index}
  \item{n.add}{the number of bases to be selected from each side of a region}
  \item{start.add}{the number of based to be selected from the start of a region}
  \item{end.add}{the number of based to be selected from the end of a region}
  \item{species}{the species i.e. human or mouse}
  \item{build}{the genome build i.e. hg19 or mm10}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{check.sort}{ should regions be checked for sort order}
  \item{check.merge}{ should overlapping regions be checked}
  \item{verbose}{should log messages and checking take place}
}
%\details{
 
%}
%\value{
 




%}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/slop.html}
}
\author{
Daryl Waggott
}


\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];
a <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
b <- grow.region(a, n.add = 20);

}
}

\keyword{ sort }
