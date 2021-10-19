\name{adjust.coordinates}
\alias{adjust.coordinates}
\title{
adjust coordinates for a BEDPE file
}
\description{
Adjust coordinates for a breakpoint in dataframe using confidence intervals specified an INFO field in the VCF file, if it exists.
Used in the `vcf2bedpe` function.
}
\usage{
adjust.coordinates(df, info_tag, start, end)
}
\arguments{
  \item{df}{a dataframe object obtained from a VCF file}
  \item{info_tag}{an info tag from the dataframe/VCF file, e.g. `CIPOS` or `CIEND`}
  \item{start}{VCF column containing the start coordinate}
  \item{end}{VCF column containing the end coordinate}
}
%\details{
%}
\value{
a named list of the adjusted start and end coordinates of a breakpoint.
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
  coordsA <- adjust.coordinates(x, 'CIPOS', x$POS, x$POS);
  coordsB <- adjust.coordinates(x, 'CIEND', x$END, x$END)
  }
}

\keyword{ vcf }
\keyword{ bedpe }