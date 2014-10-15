\name{bedr.merge.region}
\alias{bedr.merge.region}

\title{
merge i.e. collapse overlpaping regions
}
\description{

merge i.e. collapse overlpaping regions
}
\usage{
bedr.merge.region(
	x,
	distance = 0,
	list.names = TRUE,
	number = FALSE,
	stratify.by = NULL,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	verbose = TRUE
	);
}

\arguments{
  \item{x}{ input }
  \item{distance}{ maximum distance between regions to be merged.  defaults to 0 which means overlapping or bookended features. note that you can use negative distances to enforce a minimum overlap. }
  \item{list.names}{ output list of names for merged items}
  \item{number}{ output number of merged items }
  \item{stratify.by}{a column name indicating the groups to stratify merging within i.e. gene name.  merging will not happen between groups.}
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
if (check.binary("bedtools")) {

index <- get.example.regions();

a <- index[[1]];

a.sort   <- bedr.sort.region(a);
a.merged <- bedr.merge.region(a.sort);

}
}


\keyword{merge}
