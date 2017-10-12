\name{convert2bed}
\alias{convert2bed}

\title{
convert object to bed format
}
\description{
checks if an object can be converted into a bed style data.frame then does the conversion.
}
\usage{
convert2bed(
	x,
	set.type = TRUE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)
}

\arguments{
  \item{x}{A region index (i.e. chr1:10-100, ...) either as a vector or row.names/first column of a data.frame. Or a data.frame with the first three columns "chr", s"start", "end"}
  \item{set.type}{should the attribute input.type be set.  Sometimes it is desirable to avoid setting it when applying intermediate conversion}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checked for integerity}
  \item{check.sort}{should the region be checked to see if it is sorted}
  \item{check.merge}{should the region be checked for overlapping regions}
  \item{verbose}{messages and text}
}
\details{
Very useful to convert data before using other bedr functions
}
\value{
Returns x converted to bedformat, as a data frame
}
\author{
Daryl Waggott
}
\examples{
\dontrun{
  a.bed <- convert.to.bed(a) 
  }
}
\keyword{bed}
