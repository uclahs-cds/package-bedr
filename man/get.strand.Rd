\name{get.strand}
\alias{get.strand}
\title{
get BEDPE ID from VCF ID
}
\description{
Get strand informattion for each breakpoint from the VCF file (ALT or STRAND column).
Used in the `vcf2bedpe` function.
}
\usage{
get.strand(df)
}
\arguments{
  \item{df}{a dataframe object from a VCF file}
}
%\details{
%}
\value{
A column vector of strand information for each breakpoints
}
%\references{
%}
\author{
Helena Winata
}
%\seealso{
%}
\examples{
\dontrun{
  name <- get.strand(x.vcf)
  }
}

\keyword{ vcf }
\keyword{ bedpe }