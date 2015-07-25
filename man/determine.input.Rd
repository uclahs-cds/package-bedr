\name{determine.input}
\alias{determine.input}
\title{
Determine input format
}
\description{
Determine input format whether its tabular or bed
}
\usage{
determine.input(x, check.chr = FALSE, verbose = TRUE)
}
\arguments{
  \item{x}{input vector, matrix or dataframe}
  \item{check.chr}{check whether the coordinates are in chromosomal format with chr prefix}
  \item{verbose}{messages and checks}
  }
%\details{
%}
\value{
integer value. index format (0), bed (1), index in first column (2), rownmames are index (3), unrecognized(4)
}
%\references{
%}
\author{
Daryl Waggott
}
\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();
a <- index[[1]];
bedr:::determine.input(a);
}
}
\keyword{ input }
