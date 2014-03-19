\name{read_vcf}
\alias{read_vcf}
\title{
Read a vcf into R
}
\description{
Read a vcf into R and parse it for downstream analysis
}
\usage{
read_vcf(x, split.info = FALSE, split.samples = FALSE, nrows = -1, verbose = TRUE)
}
\arguments{
  \item{x}{
A vcf
}
  \item{split.info}{
Split the info into columns
}
  \item{split.samples}{
Split the sample into columns.  If multiple samples then a list matrices will be created, one matrix for each element in the FORMAT tag.
}
  \item{nrows}{
The the number of rows to be read.  Set to 0 to parse the header.
}
  \item{verbose}{
Lots of words?
}
}
\details{
The function can be slow for splitting the INFO, FORMAT for large VCFs.
}
\value{
VCF representation in R as a list.  The first element in the list is the header, the second the body of the VCF.  Every repeating tag in the header i.e. INFO, FORMAT is structured as matrix.  If reading a multi-sample VCF and the split.sample = TRUE, then a matrix is added to the list for every tag in the FORMAT string.
 
Note that by default the vcf is returned as a data.table not a data.frame.  Therefore there are some quirks i.e. subsetting via named columns a$vcf[,"CHROM", with = FALSE].  If in doubt just caset to data.frame.
}
\author{
Daryl Waggott
}


\examples{

clinVar_vcf_example      <- system.file("extdata/clinvar_dbSNP138_example.vcf.gz", package = "bedr")
singleSample_vcf_example <- system.file("extdata/singleSampleOICR_example.vcf.gz", package = "bedr")
multiSample_vcf_example  <- system.file("extdata/multiSampleOICR_example.vcf.gz", package = "bedr")

# read part of the NCBI clinVar vcf.  Note this has no samples.
vcf1.a <- read_vcf(clinVar_vcf_example)
vcf1.b <- read_vcf(clinVar_vcf_example, split.info = TRUE)
vcf1.c <- read_vcf(clinVar_vcf_example, split.info = TRUE, split.sample = TRUE) # same as above b/c no sample

# read part of a single-sample VCF
vcf2.a <- read_vcf(singleSample_vcf_example, split.info = TRUE, split.sample = TRUE)

# read part of a multi-sample VCF
vcf3.a <- read_vcf(multiSample_vcf_example, split.info = FALSE, split.sample = TRUE)

# other useful vcfs (cosmic, clinvar, 1kg)

}
\keyword{ vcf }
