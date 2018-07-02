\name{get.chr.length}
\alias{get.chr.length}

\title{
gets the length of each chromosome for a species/build
}
\description{

Gets the length of each chromosome for a species/build.  Choices are human (hg18, hg19, hg38), mouse(mm9, mm10)
}
\usage{
get.chr.length(chr = NULL, species = "human", build = "hg19")
}
\arguments{
  \item{chr}{a vector of chromosomes to query. defaults to all.}
  \item{species}{species}
  \item{build}{build}
}
%\details{
%}
\value{A dataframe with chromosome annotations}
\author{
Daryl Waggott
}
\examples{
size <- get.chr.length();
}
\keyword{length}
