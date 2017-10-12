\name{write.vcf}
\alias{write.vcf}
\title{
write a vcf object
}
\description{
write a vcf object
}
\usage{
write.vcf(x, filename = NULL, verbose = TRUE)
}
\arguments{
  \item{x}{a vcf object}
  \item{filename}{a filename}
  \item{verbose}{more words}
}
\details{
The input needs to be a vcf object.  This 
}
\value{
A vcf file
}
\references{
vcf format specifications
}
\author{
Daryl Waggott
}


\examples{

vcf  <- read.vcf(system.file("extdata/clinvar_dbSNP138_example.vcf.gz", package = "bedr"));
vcf$header <- c(vcf$header, NOTE="vcf processed by bedr")

\dontrun{
  write.vcf(vcf, filename = paste(tempdir(), "/bedr.example.vcf", sep = ""));
  }
}

\keyword{vcf}
