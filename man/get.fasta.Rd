\name{get.fasta}
\alias{get.fasta}
\title{
Query fasta sequence
}
\description{
Query fasta sequence using bedtools get.fasta
}
\usage{
get.fasta(
	x,
	fasta = NULL,
	bed12 = FALSE,
	strand = FALSE,
	output.fasta = FALSE,
	use.name.field = FALSE,
	check.zero.based = TRUE,
	check.chr = TRUE,
	check.valid = TRUE,
	check.sort = TRUE,
	check.merge = TRUE,
	verbose = TRUE
	)
}
\arguments{
  \item{x}{region or index}
  \item{fasta}{a fasta file defaults to mini example hg19 human}
  \item{bed12}{should bed12 format be used}
  \item{strand}{strand specific i.e. reverse complement negative}
  \item{output.fasta}{output a fasta defaults to a data.frame for easier parsing}
  \item{use.name.field}{should the name field be used for}
  \item{check.zero.based}{check for zero based region}
  \item{check.chr}{check for "chr" prefix }
  \item{check.valid}{check for valid regions i.e. start < end}
  \item{check.sort}{check if region is sorted}
  \item{check.merge}{check if region is merged}
  \item{verbose}{print progress}
}
\details{
Uses bedtools getFasta to query a fasta file and load into R as a data.frame for easy parsing.

Note that the hg19 reference genome fasta is large and requires on the order of 4 GB RAM to avoid a segfault happens.

}
\value{
A data.frame or fasta. The data.frame has is two columns corresponding to the region and the sequence.
}
\author{
Daryl Waggott, Syed Haider
}

\references{
\url{http://bedtools.readthedocs.org/en/latest/content/tools/getfasta.html}
}

\examples{


if (check.binary("bedtools")) {

\dontrun{

  # get the sequence for a set of regions as a data.frame
  index <- get.example.regions();
  a <- index[[1]];
  b <- get.fasta(bedr.sort.region(a));

  # this time output a fasta
  d <- get.fasta(b, output.fasta = TRUE);
  writeLines(d[[1]], con = "test.fasta");

  # get the region adjacent to a set of mutations in a vcf
  clinvar.vcf.example <- system.file(
    "extdata/clinvar_dbSNP138_example.vcf.gz", 
    package = "bedr"
    );
  clinvar <- read.vcf(clinvar.vcf.example);

  # note that clinvar uses ncbi fasta which does not use "chr" and codes chrM as MT
  clinvar.bed <- data.frame(
    chr = paste0("chr", gsub("MT", "M", clinvar$vcf$CHROM)),
    start = clinvar$vcf$POS - 2,
    end = clinvar$vcf$POS + 1,
    stringsAsFactors = FALSE
    );

  # get trinucleotide sequences of variants on chr M only
  mutation.triplet <- get.fasta(
  	clinvar.bed[which(clinvar.bed$chr == "chrM"), ], 
  	fasta = system.file("extdata/ucsc.hg19.chrM.fasta", package = "bedr"),
  	check.chr = FALSE
  	);
  }
}
}
\keyword{fasta}
