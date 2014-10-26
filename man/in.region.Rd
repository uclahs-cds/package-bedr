\name{in.region}
\alias{in.region}

\title{
checks if regions in object a are found in object b
}
\description{

checks if regions in object a are found in object b
}
\usage{
in.region(
	x,
	y,
	proportion.overlap = 1e-09,
	reciprocal.overlap = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = FALSE
	)
}

\arguments{
  \item{x}{first region index in the form chr:start-stop.  regions in this index will be checked for intersection in the values of the second index.}
  \item{y}{second region index.}
  \item{proportion.overlap}{Defaults 1e-9 which is 1 bp.  See details below for the different interpretation between 0 and 1 based overlap}
  \item{reciprocal.overlap}{Should the proportion.overlap be reciprocal}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{check if region is valid}
  \item{check.sort}{check if region is sorted}  
  \item{check.merge}{check if overlapping regions are merged}  
  \item{verbose}{prints some debugging information.  currently it just checks if the input regions are overlapping}
}
\details{
The function can also be called using syntax similar to the \%in\% operator, for example "region1 \%in.region\% region2"

The default is to report TRUE if there is 1bp overlap in zero based bed format.  That means that region chr1:10-20 and chr1:20-30 would not overlap.  To switch to one based intuitive interpretation set proportion.overlap = 0.
}
\value{
Returns a logical vector the length of x.




}
\author{
Daryl Waggott
}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/intersect.html}
}
\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];
b <- index[[2]];
a <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
b <- bedr(engine = "bedtools", input = list(i = b), method = "sort", params = "");

d <- in.region(a,b);

# alternative calling

d <- a \%in.region\% b

}
}
\keyword{in}
