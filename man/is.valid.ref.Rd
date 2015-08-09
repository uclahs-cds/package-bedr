\name{is.valid.ref}
\alias{is.valid.ref}
\title{
verifies the reference sequence in a vcf
}
\description{
verifies the reference sequence in a vcf
}
\usage{
is.valid.ref(
	x,
	fasta = NULL,
	strand = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)
}
\arguments{
  \item{x}{input bed object}
  \item{fasta }{a reference build in fasta format}
  \item{strand}{ should strand be used.  if reverse then the sequence will be reverse complemented}
  \item{check.zero.based}{should 0 based coordinates be checked}
  \item{check.chr}{should chr prefix be checked}
  \item{check.valid}{should the region be checkded for integerity}
  \item{check.sort}{ should regions be checked for sort order}
  \item{check.merge}{ should overlapping regions be checked}
  \item{verbose}{should log messages and checking take place}
}
%\details{

%}
\value{
	a logical vector the length of the input
}
%\references{
%}
\author{
Daryl Waggott
}

%\seealso{

\examples{

vcf.path <- system.file("extdata/callerA.vcf.gz", package = "bedr");
vcf.data <- read.vcf(vcf.path, split.info = TRUE);
vcf.data$vcf <- vcf.data$vcf[, 
	c("CHROM", "POS", "END", setdiff(colnames(vcf.data$vcf), c("CHROM", "POS", "END")))
	];
vcf.data$vcf$CHROM <- paste("chr", vcf.data$vcf$CHROM, sep = "");

\dontrun{
	# need reference sequence FASTA and index file to run this, as 'fasta' parameter
	is.valid.ref(vcf.data);
	}
}
\keyword{sequence }
