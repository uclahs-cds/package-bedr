\name{get.random.regions}
\alias{get.random.regions}

\title{
generates a set of random regions
}
\description{

generates a set of random regions for a specific species/build.  Choices are human (hg18, hg19), mouse(mm9, mm10). regions are sampled from a log-normal distribution.
}
\usage{
get.random.regions(
	n = 10,
	chr = NULL,
	species = "human",
	build = "hg19",
	size.mean = 10,
	size.sd = 0.25,
	mask.gaps = FALSE,
	mask.repeats = FALSE,
	sort.output = TRUE,
	verbose = TRUE
	)
}

\arguments{
  \item{n}{number of regions}
  \item{chr}{the chr or region}
  \item{species}{species}
  \item{build}{build}
  \item{size.mean}{region mean in log space}
  \item{size.sd}{region sd in log space }
  \item{mask.gaps}{should the gaps (Ns) in the human reference be ignored as potential start points.  This drammatically increases memory and run time but is more appropriate in almost all settings.  By default it's off.}
  \item{mask.repeats}{should the repeats from repeatMasker be ignored as potential start points.  This drammatically increases memory and run time but is more appropriate in almost all settings.  By default it's off.}
  \item{sort.output}{return a sorted index}
  \item{verbose}{words}
  }
%\details{
%}
%\value{
%}
\author{
Daryl Waggott
}
\examples{
test.regions <- get.random.regions(100)
}
\keyword{example}
