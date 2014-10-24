\name{df2list}
\alias{df2list}
\title{
Data frame to list conversion
}
\description{
Take data frame and return a list of rownames where column value is not 0 i.e. missing
}
\usage{
df2list(x, start.col = 1)
}
\arguments{
  \item{x}{data frame}
  \item{start.col}{offset from first column to ignore certain columns}
}
%\details{
%}
\value{
returns a list following cleanup and change of data structure
}
%\references{
%}
\author{
Daryl Waggott
}

%\seealso{
%}

\examples{
#df2list(data.frame(a = 1:10, b = 11:20));
}
%\keyword{ }
