\name{\%in_region\%}
\alias{\%in_region\%}

\title{
checks if regions in object a are found in object b
}
\description{

checks if regions in object a are found in object b
}
\usage{
x \%in_region\% y
}

\arguments{
  \item{x}{first region index in the form chr:start-stop.  regions in this index will be checked for intersection in the values of the second index.}
  \item{y}{second region index.}
}
\details{
The function can also be called using syntax similar to the \%in\% operator, for example "region1 \%in_region\% region2"
}
\value{
Returns a logical vector the length of x.




}
\author{
Daryl Waggott
}
\examples{

index <- get_example_regions();

a <- index[[1]];
b <- index[[2]];

#d <- a \%in_region\% b

}
\keyword{in}
