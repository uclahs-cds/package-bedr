\name{check.binary}
\alias{check.binary}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
checks if binary is in the path
}
\description{
check if a binary is in the path.  Specifically used for bedtools, bedops and tabix.
}
\usage{
check.binary(x = "bedtools", verbose = TRUE)
}
\arguments{
  \item{x}{a string referring to a binary/executable i.e. bedtools, bedops, tabix}
  \item{verbose}{print log}
}
\details{
Used internally to determine functionality selection options.
}
\value{
TRUE or FALSE
}
\author{
Daryl Waggott
}

\examples{
check.binary("bedtools")
}
\keyword{ binary }
