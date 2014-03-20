\name{merge_region}
\alias{merge_region}

\title{
merge i.e. collapse overlpaping regions
}
\description{

merge i.e. collapse overlpaping regions
}
\usage{
merge_region(x, distance = 0, list.names = TRUE,  number = FALSE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, check.sort = TRUE, verbose = TRUE);
}

\arguments{
  \item{x}{ input }
  \item{distance}{ distance between regions to be merged}
  \item{list.names}{ output list of names for merged items}
  \item{number}{ output number of merged items }
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{check.sort}{ should the sort order be checked}
  \item{verbose}{should log messages and checking take place}

}
%\details{
%}
%\value{
%}
\author{
Daryl Waggott
}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/merge.html}
}
\examples{
if (check_binary("bedtools")) {

index <- get_example_regions();

a <- index[[1]];

a.sort   <- sort_region(a);
a.merged <- merge_region(a.sort);

}
}


\keyword{merge}
