\name{reldist}
\alias{reldist}
\title{
Calculate the relative distance between two sets of intervals
}
\description{
Calculate the relative distance between two sets of intervals
}
\usage{
reldist(
	x,
	y,
	detail = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort =TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)
}
\arguments{
  \item{x}{firt region to be compared}
  \item{y}{second region to be compared}
  \item{detail}{should the relative distance be printed for every region}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{check.sort}{ should regions be checked for sort order}
  \item{check.merge}{ should overlapping regions be checked}
  \item{verbose}{should log messages and checking take place}
}
\details{
The frequency of relative distances in bins spanning 0 to 0.5
}
%\value{
%}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/reldist.html}
}
\author{
Daryl Waggott
}
\seealso{
jaccard
}
\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];
b <- index[[2]];
a <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
b <- bedr(engine = "bedtools", input = list(i = b), method = "sort", params = "");
reldist(a,b);

}
}
\keyword{ distance }
