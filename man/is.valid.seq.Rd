\name{is.valid.seq}
\alias{is.valid.seq}

\title{
verifies that sequences are correct given coordinates and a reference
}
\description{
verifies that sequences are correct given coordinates and a reference
}
\usage{
is.valid.seq(
	x,
	querySeq,
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
  \item{querySeq}{a vector of sequences the same length as x}
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
if (check.binary("bedtools")) {
# index <- get.example.regions();
# a <- index[[1]];
# a <- get.fasta(a);
# is.valid.seq(a)
}
}
\keyword{sequence }
