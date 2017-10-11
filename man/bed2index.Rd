\name{bed2index}
\alias{bed2index}

\title{
bed dataframe to index string
}
\description{

convert a dataframe in bed format to an index string
}
\usage{
bed2index(x, sort = TRUE)
}

\arguments{
  \item{x}{a object region object or index}
  \item{sort}{should the index be sorted}
}
%\details{
%}
\value{
Returns a vector of string based genomic regions
}
\author{
Daryl Waggott
}
\examples{

test.regions <- get.random.regions(10);
bed2index(test.regions);
}
\keyword{ bed }
