\name{is_valid_ref}
\alias{is_valid_ref}
\title{
verifies the reference sequence in a vcf
}
\description{
verifies the reference sequence in a vcf
}
\usage{
is_valid_ref(x, fasta = NULL, strand = FALSE, check.zero.based = TRUE, check.chr = TRUE, check.valid = TRUE, check.sort = TRUE, check.merge = TRUE, verbose = TRUE)
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

cosmic.path <- system.file("extdata/CosmicCodingMuts_v66_20130725_ex.vcf.gz", package = "bedr");
cosmic      <- read_vcf(cosmic.path);

#is_valid_ref(cosmic);

}
\keyword{sequence }
