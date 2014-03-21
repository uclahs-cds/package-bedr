\name{download_datasets}
\alias{download_datasets}
\title{
Download some useful datasets
}
\description{
Download some useful datasets.  Some functions such as plotting and fasta querying require additional data.
}
\usage{
download_datasets(datasets = "all", data_dir = paste0(Sys.getenv("HOME"), "/bedr/data"))
}
\arguments{
  \item{datasets}{A list of datasets to download.  Defaults to "all" i.e. c("refgene","hg19","b37","hugo", "cosmic","clinvar")}
  \item{data_dir}{A directory to put the data.  Defaults to ~/bedr/data}
  }
\details{
External datasets are required for some bedr functionality.  For example, plotting intersecdtions based on genes, get_fasta, bed2vcf and validate_gene_names.  If these datasets already exist you can simply place symlinks in a directory and use bedr_setup() to define the data_dir.
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
#download_datasets("cosmic")
}
\keyword{ data }
