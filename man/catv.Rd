\name{catv}
\alias{catv}
\title{
outputs text if verbose flag is set
}
\description{
outputs text if verbose flag is set
}
\usage{
catv(x)
}
\arguments{
  \item{x}{ some text string}
}
%\details{
%}
\value{
Prints the text string
}
\author{
Daryl Waggott
}
\examples{

verbose <- TRUE;
catv("Hello Universe!");
verbose <- FALSE;
catv("Goodbye Universe!")

}

\keyword{ cat }
