\name{permute.region}
\alias{permute.region}
\title{
permute a set of regions
}
\description{
permute a set of regions
}
\usage{
permute.region(
	x,
	stratify.by.chr = FALSE,
	species = "human",
	build = "hg19",
	chr.names = paste0("chr",c(1:22,"X","Y","M")),
	mask.gaps = FALSE,
	gaps.file = NULL,
	mask.repeats = FALSE,
	repeats.file = NULL,
	sort.output = TRUE,
	is.checked = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	verbose = TRUE
	)
}
\arguments{
  \item{x}{regions to permute}
  \item{stratify.by.chr}{Should the permutation be happen separetely for each chromosome.  That is are chromosomes exchangeable.}
  \item{species}{species}
  \item{build}{the build of the reference}
  \item{chr.names}{names of the chromosomes to use}
  \item{mask.gaps}{should the gaps (Ns) in the human reference be ignored as potential start points.  This drammatically increases memory and run time but is more appropriate in almost all settings.  It defaults to off}
  \item{gaps.file}{database file of gaps. Defaults to Homo sapiens Hg19 gap.txt.gz file available through UCSC}
  \item{mask.repeats}{should the repeats from repeatMasker be ignored as potential start points.  This drammatically increases memory and run time but is more appropriate in almost all settings.  By default it's off}
  \item{repeats.file}{database file of repeats as supplied by UCSC containing RepMasker data e.g rmsk.txt.gz}
  \item{sort.output}{should the output be sorted}
  \item{is.checked}{Has the input data already be tested for validity.  This is often done once before multiple permutations.}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{verbose}{should log messages and checking take place}
}
\details{
1. Sampling with replacement on region length. 
2. Sampling with replacement on start positions.  Positions that contain Ns in the reference are set to 0 weight during sampling.

Regions that overlap the end of a chromosome or gap are trimmed.

Steps 1 and 2 are done within chromosomes if stratify.by.chr is set to true.
}
\value{
A region object with randomized start positions.
}
\author{
Daryl Waggott
}


\examples{
if (check.binary("bedtools")) {

index <- get.example.regions();
a <- index[[1]];
a <- bedr(engine = "bedtools", input = list(i = a), method = "sort", params = "");
a.perm <- permute.region(a);

}
}

\keyword{ permute }
