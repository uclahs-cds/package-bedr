\name{jaccard}
\alias{jaccard}
\title{
calculate the jaccard distance between sets of intervals
}
\description{
calculate the jaccard distance between sets of intervals
}
\usage{
jaccard(
	x,
	y,
	proportion.overlap = 1e-09,
	reciprocal.overlap = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)
}
\arguments{
  \item{x}{first region to be compared}
  \item{y}{second region to be compared}
  \item{proportion.overlap}{Defaults 1e-9 which is 1 bp.  See details below for the different interpretation between 0 and 1 based overlap}
  \item{reciprocal.overlap}{Should the proportion.overlap be reciprocal}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{check.sort}{ should regions be checked for sort order}
  \item{check.merge}{ should overlapping regions be checked}
  \item{verbose}{should log messages and checking take place}
}
\details{
The Jaccard metric is the ratio of intersections to unions.  The process can be tweaked by changing the proportion of overlap and even growiwng the regions.
}
\value{
A short vector.
}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/jaccard.html}
}
\author{
Daryl Waggott
}


\seealso{
reldist
}
\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];
b <- index[[2]];
a <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
b <- bedr(engine = "bedtools", input = list(i = b), method = "sort", params = "");
jaccard(a,b);

}
}
\keyword{ distance }
