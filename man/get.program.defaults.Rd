\name{get.program.defaults}
\alias{get.program.defaults}
\title{A utility function to return the inst/extdata/ directory of the installed package and other default settings}
\description{A utility function to return the inst/extdata/ directory of the installed package to get the program related data contents}
\usage{
get.program.defaults()
}
\value{Returns a list of path/s to the input directories/files where the contents of this package are installed}
\author{Syed Haider}
\examples{
program.data <- get.program.defaults();
}
\keyword{IO}
