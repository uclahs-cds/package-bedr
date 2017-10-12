\name{index2bed}
\alias{index2bed}

\title{
convert a region index into a bed file dataframe
}
\description{
convert a region index into a bed file dataframe

}
\usage{
index2bed(x, set.type = TRUE)
}

\arguments{
  \item{x}{an index}
  \item{set.type}{should the attribute input.type be set.  Sometimes it is desirable to avoid setting it when applying intermediate conversion}
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
a.bed <- index2bed(a);
}
}
\keyword{bedtools}
