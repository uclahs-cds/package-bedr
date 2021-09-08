\name{vcf2bedpe}
\alias{vcf2bedpe}
\title{
convert a vcf to a bedpe file
}
\description{
Convert a vcf to a bedpe file. Currently, it needs to read into R via read.vcf
}
\usage{
vcf2bedpe(x, filename = NULL, header = FALSE, other = NULL, verbose = TRUE)
}
\arguments{
  \item{x}{a vcf object}
  \item{filename}{the name of the output bedpe file, if NULL then bedpe is not exported}
  \item{header}{indicate if the bed file has header or not when exported}
}
%\details{
%}
\value{
A bedpe styled R object or an external file
}
%\references{
%}
\author{
Helena Winata
}
%\seealso{
%}
\examples{
delly.vcf.example <- system.file("extdata/dellySV.vcf.gz", package = "bedr")
x <- read.vcf(delly.vcf.example)
x.bedpe <- vcf2bed(x)
}
\keyword{ vcf }

