\name{download.datasets}
\alias{download.datasets}
\title{
Download some useful datasets
}
\description{
Download some useful datasets.  Some functions such as plotting and fasta querying require additional data.
}
\usage{
download.datasets(datasets = "all", data.dir = paste0(Sys.getenv("HOME"), "/bedr/data"))
}
\arguments{
  \item{datasets}{A list of datasets to download.  Defaults to "all" i.e. c("refgene","hg19","b37","hugo", "cosmic","clinvar")}
  \item{data.dir}{A directory to put the data.  Defaults to ~/bedr/data}
  }
\details{
External datasets are required for some bedr functionality.  For example, plotting intersections based on genes, get.fasta, bed2vcf and validate.gene.names.  If these datasets already exist you can simply place symlinks in a directory and use bedr.setup() to define the data.dir.
}
\value{
some datasets.
}
%\references{
%}
\author{
Daryl Waggott
}

%\seealso{
%}
\examples{
\dontrun{
  download.datasets("cosmic");
  }
}
\keyword{ data }
