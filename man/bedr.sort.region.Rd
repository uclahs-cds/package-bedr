\name{bedr.sort.region}
\alias{bedr.sort.region}

\title{
sort a region file
}
\description{

sort a region file
}
\usage{
bedr.sort.region(
	x,
	method = "lexicographical",
	engine = "R",
	chr.to.num = c("X" = 23, "Y" = 24, "M" = 25),
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)

}

\arguments{
  \item{x}{a region object or index}
  \item{method}{natural or lexicographic}
  \item{engine}{what analytical engine to use for sorting i.e. bedtools, bedops, gnu unix}
  \item{chr.to.num}{chromosome letter names to numbers map. Defaults to Homo sapiens i.e c("X" = 23, "Y" = 24, "M" = 25)}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checked for integerity}
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
if (check.binary("bedtools")) {

index <- get.example.regions();
a <- index[[1]];
b <- bedr.sort.region(a);

}
}

\keyword{ sort }
