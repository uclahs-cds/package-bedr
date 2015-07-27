\name{bedr.subtract.region}
\alias{bedr.subtract.region}

\title{
subtracts features or ranges in object b from object a
}
\description{
subtracts features or ranges in object b from object a
}
\usage{
bedr.subtract.region(
	x,
	y,
	fraction.overlap = 1/1e9,
	remove.whole.feature = TRUE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)
}

\arguments{
  \item{x}{item a}
  \item{y}{item b}
  \item{fraction.overlap}{ what portion of A to be considered an overlap}
  \item{remove.whole.feature}{ should whole feature be removed }
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{check.sort}{check if region is sorted} 
  \item{check.merge}{check if overlapping regions are merged} 
  \item{verbose}{ messages and checks}
}
%\details{
%}
\value{
Regions exclusive to one object of regions.
}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/subtract.html}
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
d <- bedr.subtract.region(a,b);
}
}
\keyword{subtract}
