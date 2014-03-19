\name{read_ucsc}
\alias{read_ucsc}
\title{
read a ucsc table into R
}
\description{
read a ucsc table into R
}
\usage{
read_ucsc(x, mirror = "http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database", verbose = TRUE)
}
\arguments{
  \item{x}{
a ucsc data table.  Include the ".gz" extension unless you would like to load from a local file.
}
  \item{mirror}{
the ucsc mirror
}
  \item{verbose}{
more words
}
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
# read_ucsc("refGene")

}

\keyword{ ucsc }
