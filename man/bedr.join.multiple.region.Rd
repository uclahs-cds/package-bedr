\name{bedr.join.multiple.region}
\alias{bedr.join.multiple.region}

\title{
join multiple region objects
}
\description{
join multiple objects

}
\usage{
bedr.join.multiple.region(
	x = list(),
	fraction.overlap = 1/1e9,
	empty = FALSE,
	missing.values = ".",
	cluster = FALSE,
	species = "human",
	build = "hg19",
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)
}

\arguments{
  \item{x}{ list of region objects}
  \item{fraction.overlap}{proportion of bases to be considered an overlap}
  \item{empty}{print rows if no match}
  \item{missing.values}{missing value character}
  \item{cluster}{TRUE/FALSE for clustering}
  \item{species}{species i.e. human or mouse}
  \item{build}{genome build to use for empty regions}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{check if region is valid}
  \item{check.sort}{check if region is sorted}
  \item{check.merge}{check if overlapping regions are merged}
  \item{verbose}{messages and checks}
}
%\details{
%\value{
%}
\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/multiinter.html}
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
d <- get.random.regions(100, chr="chr1", sort = TRUE);

a.mult <- bedr.join.multiple.region(x = list(a.sort,b.sort,bedr.sort.region(d)));
}
}
\keyword{ join }
