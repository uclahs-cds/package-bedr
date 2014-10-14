context("index2bed")

test.that("check that index to bed conversion is working", {

	regions <- get.example.regions()
	chr.dat <- c("chr1",  "chr1",  "chr1",  "chr1",  "chr2",  "chr10", "chr2",  "chr20")
	start.dat <- c(10, 101, 200, 211,  10,  50,  40,   1)
	end.dat <- c(100, 200, 210, 212,  50, 100,  60,   5)
	region.a.bed <- data.frame(chr=chr.dat,start=start.dat,end=end.dat, stringsAsFactors=F)

	expect.equal(index2bed(regions$a), region.a.bed)

	})

