\name{cluster.region}
\alias{cluster.region}
\title{
cluster intervals
}
\description{
cluster intervals
}
\usage{
cluster.region(
	x,
	distance = 0,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	verbose = TRUE
	)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{The region}
  \item{distance}{ maximum distance between regions to be merged.  defaults to 0 which means overlapping or bookended features. note that you can use negative distances to enforce a minimum overlap. }
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{check.sort}{ should regions be checked for sort order}
  \item{verbose}{should log messages and checking take place}
}
\details{
clusters adjacent features of a specified distance.
}
\value{
A data.frame in bed format
}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/cluster.html}
}
\author{
Daryl Waggott
}


\seealso{
\code{\link{bedr.merge.region}}
}
\examples{

if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];

b <- cluster.region(a, distance = 0);
d <- cluster.region(a, distance = 100);

}
}
\keyword{ cluster }
\keyword{ merge }
