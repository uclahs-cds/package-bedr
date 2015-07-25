\name{tabix}
\alias{tabix}

\title{
Main bedtools wrapper function.
}
\description{
Main bedtools wrapper function.
}
\usage{
tabix(
	region,
	file.name,
	params = NULL,
	tmpDir = NULL,
	deleteTmpDir = TRUE,
	outputDir = NULL,
	outputFile = NULL,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)

}

\arguments{
	\item{region}{The regions to query the tabix'd file}
	\item{file.name}{The name of the bzipped/indexed tabix file to query}
	\item{params}{A string that includes all the extra parameters and arguments to the bedtools commmand.  For example if you wanted to do a left outer join you would specificy method as intersect and use params = c("-loj -header"). If you leave input and method as defaults then this is this string represents the full command.}
  \item{tmpDir}{The directory to be used for writing files}
  \item{deleteTmpDir}{Should tmp files be deleted.  helpful for diagnostics.}
  \item{outputDir}{The output directory.  Only used if outputFile is specified.  It defaults to the current working directory.}
  \item{outputFile}{The name of the output file.  If this is specified the output will be sent to a file not an R object}
  \item{check.chr}{check for chr prefix}
  \item{check.zero.based}{check for zero based coordinates}
  \item{check.valid}{do all region integrity checks}
  \item{check.sort}{check if region is sorted}
  \item{check.merge}{check if region is  merged}
  \item{verbose}{Should messages be printed to screen.}
}
%\details{
%}
\value{
The output of command with some parsing to keep it consistent with the input. 

}
\author{
Daryl Waggott
}


\seealso{
genomicRanges
}
\examples{
if (check.binary("tabix")) {
query.regions <- c("1:1000-100000", "1:1000000-1100000")
cosmic.vcf.example <- system.file(
	"extdata/CosmicCodingMuts_v66_20130725_ex.vcf.gz",
	package = "bedr"
	)
cosmic.query <- tabix(query.regions, cosmic.vcf.example, check.chr = FALSE)
}
}
\keyword{bedtools}
\keyword{bedops}
\keyword{tabix}
\keyword{region}
\keyword{interval}
\keyword{bed}
