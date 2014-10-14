\name{is.valid.region}
\alias{is.valid.region}
\title{
checks if region/index is valid
}
\description{
checks if region/index is valid
}
\usage{
is.valid.region(
	x,
	check.zero.based = TRUE,
	check.chr = TRUE,
	throw.error = FALSE,
	verbose = TRUE
	)
}
\arguments{
  \item{x}{The region index, bed file, or bed formatted object}
  \item{check.zero.based}{should basic test for zero based coordinates be checked}
  \item{check.chr}{should the algorithm check for the "chr" prefix}
  \item{throw.error}{should an error be thrown.  The default is to report a logical vector of inconsistencies.}
  \item{verbose}{should diagnostic messages be printed}
}
%\details{
%}
%\value{
%}
\author{
Daryl Waggott
}
\examples{
index <- get.example.regions();

a <- index[[1]];
is.valid <- is.valid.region(a);
a.valid <- a[is.valid];

}

\keyword{ example }
