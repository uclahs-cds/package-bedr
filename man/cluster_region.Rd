\name{cluster_region}
\alias{cluster_region}
\title{
cluster intervals
}
\description{
cluster intervals
}
\usage{
cluster_region(x, distance = 0, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, check.sort = TRUE, verbose = TRUE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{The region}
  \item{distance}{The distance between features.  Defaults to 0 i.e. overlapping, bookended.}
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
\code{\link{merge_region}}
}
\examples{

if (check_binary("bedtools")) {

index <- get_example_regions();

a <- index[[1]];

b <- merge_region(a, distance = 0);
d <- merge_region(a, distance = 100);

}
}
\keyword{ cluster }
\keyword{ merge }
