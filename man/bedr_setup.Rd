\name{bedr_setup}
\alias{bedr_setup}

\title{
Initialize some config settings for bedr
}
\description{
Initialize some config settings for bedr.  This includes downloading useful datasets if requested.
}
\usage{
bedr_setup(datasets = "all", data_dir = paste0(Sys.getenv("HOME"), "/bedr/data"))
}
\arguments{
  \item{datasets}{A list of datasets to download.  Defaults to "all" i.e. c("refgene","hg19","b37","hugo", "cosmic","clinvar")}
  \item{data_dir}{A directory to put the data.  Defaults to ~/bedr/data}
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
#bedr_setup()
}
\keyword{ config }
