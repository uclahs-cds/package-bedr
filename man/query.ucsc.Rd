\name{query.ucsc}
\alias{query.ucsc}
\title{
read a ucsc table into R
}
\description{
read a ucsc table into R
}
\usage{
query.ucsc(
	x,
	mirror = "http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database",
	download = TRUE,
	overwrite.local = FALSE,
	columns.keep = NULL,
	verbose = TRUE
	)
}
\arguments{
  \item{x}{a ucsc data table.  Include the full path including "txt.gz" extenstion to load from a local file.  Note that $HOME/bedr/data will be checked first before downloading.}
  \item{mirror}{the ucsc mirror}
  \item{download}{should the data be downloaded to $HOME/bedr/data/}
  \item{overwrite.local}{should the local version be overwritten if it exists}
  \item{columns.keep}{what columns to load.  this can help with very large tables where you only want 'chr,start,end'. defaults to all.  you may have to check the sql for the actual column names.}
  \item{verbose}{more words}
}
\details{
tables can be found at \url{http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database}
}
\value{
A data.frame
}
%\references{
%}
\author{
Daryl Wagott
}

\examples{
# query.ucsc("refGene")

}

\keyword{ ucsc }
