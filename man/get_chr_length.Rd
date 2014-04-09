\name{get_chr_length}
\alias{get_chr_length}

\title{
gets the length of each chromosome for a species/build
}
\description{

Gets the length of each chromosome for a species/build.  Choices are human (hg18, hg19), mouse(mm9, mm10)
}
\usage{
get_chr_length(chr = NULL, species = "human", build = "hg19")

}

\arguments{
  \item{chr}{a vector of chromosomes to query. defaults to all.}
  \item{species}{species}
  \item{build}{build}
}
%\details{
%}
%\value{
%}
\author{
Daryl Waggott
}

\examples{
size <- get_chr_length();
}
\keyword{length}
