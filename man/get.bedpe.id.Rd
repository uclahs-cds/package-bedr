\name{get.bedpe.id}
\alias{get.bedpe.id}
\title{
get BEDPE ID from VCF ID
}
\description{
Get IDs for each breakpoint pair from the VCF file.
Used in the `vcf2bedpe` function.
}
\usage{
get.bedpe.id(df)
}
\arguments{
  \item{df}{a dataframe object from a VCF file}
}
%\details{
%}
\value{
A column vector of names assigned to each Structural Variant in the BEDPE file
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
  name <- get.bedpe.id(x.vcf)
  }
}

\keyword{ vcf }
\keyword{ bedpe }