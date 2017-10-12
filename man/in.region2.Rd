\name{\%in.region\%}
\alias{\%in.region\%}

\title{
checks if regions in object a are found in object b
}
\description{

checks if regions in object a are found in object b
}
\usage{
x \%in.region\% y
}

\arguments{
  \item{x}{first region index in the form chr:start-stop.  regions in this index will be checked for intersection in the values of the second index.}
  \item{y}{second region index.}
}
\details{
The function can also be called using syntax similar to the \%in\% operator, for example "region1 \%in.region\% region2"
}
\value{
Returns a logical vector the length of x.

}
\author{
Daryl Waggott
}
\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];
b <- index[[2]];
a <- bedr.sort.region(a);
b <- bedr.sort.region(b);

d <- a \%in.region\% b

}
}
\keyword{in}
