\name{vcf2bed}
\alias{vcf2bed}
\title{
convert a vcf to a bed file
}
\description{
Convert a vcf to a bed file.  Currently, it needs to read into R via read.vcf
}
\usage{
vcf2bed(x, filename = NULL, header = FALSE, other = NULL, verbose = TRUE)
}
\arguments{
  \item{x}{a vcf object}
  \item{filename}{the name of file if you want it exported}
  \item{header}{indicate if the bed file has header or not when exported}
  \item{other}{fields to include apart from chr, start, end.}
  \item{verbose}{more words}
}
%\details{
%}
\value{
A bed styled R object or an external file
}
%\references{
%}
\author{
Daryl Waggott
}
%\seealso{
%}
\examples{
clinVar.vcf.example <- system.file("extdata/clinvar_dbSNP138_example.vcf.gz", package = "bedr")
x <- read.vcf(clinVar.vcf.example)
x.bed <- vcf2bed(x)
}
\keyword{ vcf }
