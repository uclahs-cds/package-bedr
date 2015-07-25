\name{snm}
\alias{snm}

\title{
sort a region file
}
\description{
Sort and merge regions object in one step
}
\usage{
snm(
	x,
	method = "lexicographical",
	distance = 0,
	list.names = TRUE,
	number = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	verbose = TRUE
	)

}

\arguments{
  \item{x}{ a object region object or index}
  \item{method}{natural or lexicographic}
  \item{distance}{ distance between regions to be merged}
  \item{list.names}{ output list of names for merged items}
  \item{number}{ output number of merged items }
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{verbose}{should log messages and checking take place}
}
%\details{
 
%}
\value{
Sorted and merged and regions object 
}
\author{
Daryl Waggott
}
\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];

b <- snm(a);

}
}
\keyword{ sort }
