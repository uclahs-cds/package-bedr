\name{bedr.setup}
\alias{bedr.setup}

\title{
Initialize some config settings for bedr
}
\description{
Initialize some config settings for bedr. This includes downloading useful datasets if requested.
}
\usage{
bedr.setup(datasets = "all", data.dir = paste0(Sys.getenv("HOME"), "/bedr/data"))
}
\arguments{
  \item{datasets}{A list of datasets to download.  Defaults to "all" i.e. c("refgene","hg19","b37","hugo", "cosmic","clinvar")}
  \item{data.dir}{A directory to put the data.  Defaults to ~/bedr/data}
}
\details{
The default config file is at ~/bedr/config.yml.  It's in yaml format.
}
%\value{
%}
%\references{
%}
\author{
Daryl Waggott
}

\examples{
\dontrun{
  bedr.setup()
  }
}
\keyword{ config }
