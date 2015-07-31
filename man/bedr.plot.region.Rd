\name{bedr.plot.region}
\alias{bedr.plot.region}
\title{
Visualize regions or intervals
}
\description{
Visualize regions or intervals.  e.g. VennDiagrams of intersections of distinct intervals, base pairs and genes. 
}
\usage{
bedr.plot.region(
	input,
	filename = NULL,
	type = "venn",
	feature = "interval",
	fraction.overlap = 0.000000001,
	group = NULL,
	params = list(),
	verbose = TRUE
	)
}
\arguments{
  \item{input}{ 
A list of input regions or indices
}
  \item{filename}{
The name of the output image file
}
  \item{type}{
The type of plot. only 'venn' is supported for intersections at the moment.
}
  \item{feature}{
How should the regions be intersected.  By unique "interval", "gene", "size" or "other" to use the features in the first item in the input list.
}
  \item{fraction.overlap}{
Minimum overlap required as a fraction of A. Default is 1E-9 (i.e. 1bp).
}
  \item{group}{
A grouping parameter for barplots.  Possible values include "input", "chr", or a categorical vector of length equal to the sum of the input.
}
  \item{params}{
Additional parameters for plotting or intersecting.  See \code{\link{venn.diagram}} function for possible options.
}
  \item{verbose}{
Include text messages.
}
}
\details{
By default a venn diagram is output.  If a single input is used then the plot shows the number of unique and collapsed regions after applying a merge.
}
\value{
Plots!
}
\author{
Daryl Waggott
}
\examples{
if (check.binary("bedtools")) {
	# example data
	a <- get.random.regions(n = 1000, chr = "chr22", size.mean = 10)
	b <- get.random.regions(n = 1000, chr = "chr22", size.mean = 10)
	d <- get.random.regions(n = 1000, chr = "chr22", size.mean = 10)
	e <- get.random.regions(n = 1000, chr = "chr22", size.mean = 10)
	f <- get.random.regions(n = 1000, chr = "chr22", size.mean = 10)

	pdf("bedr.plot.region.ex.pdf")

	# basic venn diagrams
	bedr.plot.region(input = list(a=a,b=b))
	bedr.plot.region(input = list(a=a,b=b,d=d))
	#bedr.plot.region(input = list(a=a,b=b,d=d,e=e))
	#bedr.plot.region(input = list(a=a,b=b,d=d,e=e,f=f))

	### change venn parameters
	bedr.plot.region(
		input = list(a=a,b=b,d=d),
		params = list(lty = 2, label.col = "black", main = "Region Overlap")
		)

	### try with different 
	#bedr.plot.region(input = list(a=a,b=b), feature = "gene")
	#bedr.plot.region(input = list(a=a,b=b), feature = "reference")
	#bedr.plot.region(input = list(a=a,b=b), feature = "interval")
	#bedr.plot.region(input = list(a=a,b=b), feature = "cluster")
	#bedr.plot.region(input = list(a=a,b=b), feature = "bp")

	dev.off()
	}
}

\keyword{ plot }
\keyword{ venn }
