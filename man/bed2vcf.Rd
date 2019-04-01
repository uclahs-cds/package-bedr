\name{bed2vcf}
\alias{bed2vcf}
\title{
convert bed to vcf
}
\description{
convert bed to vcf
}
\usage{
bed2vcf(x, filename = NULL, zero.based = TRUE, header = NULL, fasta = NULL)
}
\arguments{
  \item{x}{
the input bed object
}
  \item{filename}{
a filename to write to.
}
  \item{zero.based}{
is the file zero based i.e. bed format.  defaults to true.
}
  \item{header}{
a list of things to put in the header.  repeated elements such as INFO, FILTER, FORMAT can be put in data.frames.
}
  \item{fasta}{
build of the genome in fasta format
}
}
%\details{
%}
%\value{
%}
%\references{
%}
\author{
Daryl Waggott
}
\examples{
\dontrun{
  bed2vcf(x)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
