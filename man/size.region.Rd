\name{size.region}
\alias{size.region}
\title{
Get region size
}
\description{
Get region size
}
\usage{
size.region(
	x, 
	zero.based = TRUE, 
	check.zero.based = TRUE, 
	check.chr = TRUE, 
	check.valid = TRUE, 
	verbose = TRUE
	)
}
\arguments{
  \item{x}{region in vector, matrix or dataframe format}
  \item{zero.based}{whether the coordinates are zero-based or 1}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checked for integerity}
  \item{verbose}{messages and checks}
}
%\details{
%}
\value{
size/length of the region
}
%\references{
%}
\author{
Daryl Waggott
}
\seealso{
convert2bed
}
\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];

a.sizes <- bedr:::size.region(a);
}
}
\keyword{region}
