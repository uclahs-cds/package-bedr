\name{order.region}
\alias{order.region}

\title{
Gets the sort order of a region index similar to the order command
}
\description{
Helps if you don't want to use sort region on a huge dataset
}
\usage{
order.region(
	x,
	method = "lex",
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.merge = TRUE
	)
}

\arguments{
  \item{x}{index or bed style data.frame}
  \item{method}{natural or lexicographical (lex)}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{check if region is valid}
  \item{check.merge}{check if region is sorted and merged} 

}
%\details{
%}
%\value{
%}
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
a <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
a.order <- order.region(a)

b <- a[a.order];

}
}
\keyword{order }
\keyword{sort }
