\name{read.vcf}
\alias{read.vcf}
\title{
Read a vcf into R
}
\description{
Read a vcf into R and parse it for downstream analysis
}
\usage{
read.vcf(x, split.info = FALSE, split.samples = FALSE, nrows = -1, verbose = TRUE)
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
print progress
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

clinVar.vcf.example      <- system.file("extdata/clinvar_dbSNP138_example.vcf.gz", package = "bedr")
singleSample.vcf.example <- system.file("extdata/singleSampleOICR_example.vcf.gz", package = "bedr")
multiSample.vcf.example  <- system.file("extdata/multiSampleOICR_example.vcf.gz", package = "bedr")

# read a subset of NCBI clinVar vcf.  Note this has no samples.
vcf1.a <- read.vcf(clinVar.vcf.example)
vcf1.b <- read.vcf(clinVar.vcf.example, split.info = TRUE)

\dontrun{

# same as above but split multiple samples
vcf1.c <- read.vcf(clinVar.vcf.example, split.info = TRUE, split.sample = TRUE) 

# read a single-sample VCF
system.time(
  vcf2.a <- read.vcf(singleSample.vcf.example, split.info = TRUE, split.sample = TRUE)
  )

# read a multi-sample VCF
vcf3.a <- read.vcf(multiSample.vcf.example, split.info = FALSE, split.sample = TRUE);

# multi core example
options("cores"=9);
vcf2.a <- read.vcf(singleSample.vcf.example, split.info = TRUE, split.sample = TRUE)
options("cores"=1);

}
}
\keyword{ vcf }
