\name{is.sorted.region}
\alias{is.sorted.region}
\title{
checks if region file is sorted
}
\description{
checks if region file is sorted
}
\usage{
is.sorted.region(
	x,
	method = "lex",
	engine = "unix",
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.merge = TRUE,
	verbose = FALSE
	)
}
\arguments{
  \item{x}{The region index, bed file, or bed formatted object}
  \item{method}{lexicgraphical or natural, lex is required for many operations but natural is better for interpretation}
  \item{engine}{what analytical engine to use for sorting i.e. bedtools, bedops, gnu unix}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{check if region is valid}
  \item{check.merge}{check if region is merged}
  \item{verbose}{more words}
}
%\details{ 
%}
%\value{
%}
\author{
Daryl Waggott
}
\examples{
if (check.binary("bedtools")) {
index <- get.example.regions();

a <- index[[1]];

b <- is.sorted.region(a);
}
}

\keyword{ ~kwd1 }
