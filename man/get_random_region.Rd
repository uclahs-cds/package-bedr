\name{get_random_regions}
\alias{get_random_regions}

\title{
generates a set of random regions
}
\description{

generates a set of random regions for a specific species/build.  Choices are human (hg18, hg19), mouse(mm9, mm10). regions are sampled from a log-normal distribution.
}
\usage{
get_random_regions(n = 10, chr = "chr22", species = "human", build = "hg19", size.mean = 5, size.sd = 1, sort.output = TRUE)

}

\arguments{
  \item{n}{number of regions}
  \item{chr}{the chr or region}
  \item{species}{species}
  \item{build}{build}
  \item{size.mean}{region mean in log space}
  \item{size.sd}{region sd in log space }
  \item{mask.unmapped}{should the gaps in the reference build be masked.  this adds time.}
  \item{sort.output}{return a sorted index}
}
%\details{
%}
%\value{
%}
\author{
Daryl Waggott
}
\examples{
# test.regions <- get_example_regions(100)
}
\keyword{example}
