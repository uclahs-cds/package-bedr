\name{is.merged.region}
\alias{is.merged.region}

\title{
checks if region file is merged
}
\description{
checks if region file is merged
}
\usage{
is.merged.region(
	x,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	verbose = FALSE
	)
}

\arguments{
  \item{x}{region or index}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{check if region is valid}
  \item{check.sort}{check if region is sorted}
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

b <- is.merged.region(a);

}
}

