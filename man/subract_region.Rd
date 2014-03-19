\name{subtract_region}
\alias{subtract_region}

\title{
subtracts features or ranges in object b from object a
}
\description{
subtracts features or ranges in object b from object a
}
\usage{
  subtract_region(x, y, fraction.overlap = 1/1e9, remove.whole.feature = TRUE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, check.sort = TRUE, check.merge = TRUE, verbose = TRUE)
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
%\value{
%}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/subtract.html}
}
\author{
Daryl Waggott
}
\examples{
if (check_binary("bedtools")) {
index <- get_example_regions();

a <- index[[1]];
b <- index[[2]];

d <- subtract_region(a,b);

}
}
\keyword{subtract}
