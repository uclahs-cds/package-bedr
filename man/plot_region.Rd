\name{plot_region}
\alias{plot_region}
\title{
Visualize regions or intervals
}
\description{
Visualize regions or intervals.  e.g. VennDiagrams of intersections of distinct intervals, base pairs and genes. 
}
\usage{
plot_region(input, filename = NULL, type = "venn", feature = "interval", fraction.overlap = 0.000000001, group = NULL, params = list(), verbose = TRUE)
}
\arguments{
  \item{input}{ 
A list of input regions or indices
}
  \item{filename}{
The name of the output image file
}
  \item{type}{
The type of plot including venn for intersections and barplots for score metrics
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
# example data
a <- get_random_regions(n = 1000, chr = "chr22", size.mean = 10)
b <- get_random_regions(n = 1000, chr = "chr22", size.mean = 10)
d <- get_random_regions(n = 1000, chr = "chr22", size.mean = 10)
e <- get_random_regions(n = 1000, chr = "chr22", size.mean = 10)
f <- get_random_regions(n = 1000, chr = "chr22", size.mean = 10)

#pdf("plot_region_ex.pdf")

### basic venn diagrams
#plot_region(input = list(a=a)) # note single inputs compare the original with a merged/collapsed set of regions
#plot_region(input = list(a=a,b=b))
#plot_region(input = list(a=a,b=b,d=d))
#plot_region(input = list(a=a,b=b,d=d,e=e))
#plot_region(input = list(a=a,b=b,d=d,e=e,f=f))

### change venn parameters
#plot_egion(input = list(a=a,b=b,d=d), params = list(lty = 2, label.col = "black", main = "Region Overlap"))

### try with different 
#plot_region(input = list(a=a,b=b), feature = "gene")
#plot_region(input = list(a=a,b=b), feature = "reference")
#plot_region(input = list(a=a,b=b), feature = "interval")
#plot_region(input = list(a=a,b=b), feature = "cluster")
#plot_region(input = list(a=a,b=b), feature = "bp")

#dev.off()
}

\keyword{ plot }
\keyword{ venn }
