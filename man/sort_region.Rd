\name{sort_region}
\alias{sort_region}

\title{
sort a region file
}
\description{

sort a region file
}
\usage{
sort_region(x, method = "lexicographical", engine = "R", check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, check.merge = TRUE, verbose = TRUE)

}

\arguments{
  \item{x}{a region object or index}
  \item{method}{natural or lexicographic}
  \item{engine}{what analytical engine to use for sorting i.e. bedtools, bedops, gnu unix}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{check.merge}{ should overlapping regions be checked}
  \item{verbose}{should log messages and checking take place}
}
%\details{
 
%}
%\value{
 




%}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/sort.html}
}
\author{
Daryl Waggott
}


\examples{
if (check_binary("bedtools")) {

index <- get_example_regions();

a <- index[[1]];

b <- sort_region(a);

}
}

\keyword{ sort }
