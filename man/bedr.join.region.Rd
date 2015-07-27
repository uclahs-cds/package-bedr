\name{bedr.join.region}
\alias{bedr.join.region}

\title{
join two region objects using a left outer join
}
\description{
join two region objects using a left outer join

}
\usage{
bedr.join.region(
	x,
	y,
	fraction.overlap = 1/1e9,
	reciporical = FALSE,
	report.n.overlap = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)
}

\arguments{
  \item{x}{ object a}
  \item{y}{ object b}
  \item{fraction.overlap}{proportion of overlap to be considered a match}
  \item{report.n.overlap}{should the number of overlapping bases be reported}
  \item{reciporical}{should the fraction overlap be applied to object b as well}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{check if region is valid}
  \item{check.sort}{check if region is sorted} 
  \item{check.merge}{check if overlapping regions are merged} 
  \item{verbose}{messages and checks}
}
%\details{
%}
%\value{
%}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/intersect.html}
}
\author{
Daryl Waggott
}
\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];
b <- index[[2]];

a.sort <- bedr.sort.region(a);
b.sort <- bedr.sort.region(b);

d <- bedr.join.region(a.sort, b.sort);
}
}

\keyword{ join}
