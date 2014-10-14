\name{vcf2bed}
\alias{vcf2bed}
\title{
convert a vcf to a bed file
}
\description{
Convert a vcf to a bed file.  Currently, it needs to read into R via read.vcf
}
\usage{
vcf2bed(x, filename = NULL, other = NULL)
}
\arguments{
  \item{x}{a vcf object}
  \item{filename}{the name of file if you want it exported}
  \item{other}{fields to include apart from chr, start, end.  }
}
%\details{
%}
\value{
A bed file styled R object or an external file
}
%\references{
%}
\author{
Daryl Waggott
}


%\seealso{
%}
\examples{
# read.vcf(x)
# vcf2bed(x)
}
\keyword{ vcf }
