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

bed <- get.example.regions()[[1]];
bed <- snm(bed);

#vcf <- bed2vcf(bed, header = list(note="a bedr example vcf"));
vcf  <- read.vcf(system.file("extdata/clinvar.dbSNP138.example.vcf.gz", package = "bedr"));
vcf$header <- c(vcf$header, NOTE="vcf processed by bedr")
write.vcf(vcf, filename = "bedr.example.vcf");

}

\keyword{vcf}