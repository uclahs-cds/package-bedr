context("is.sorted.region")

if (check.binary("bedtools", verbose = TRUE)) {

test_that("correctly identifies if regions are sorted", {	
	
	regions <- get.example.regions()
	regions.a.sorted <- c("chr1:10-100", "chr1:101-200", "chr1:200-210", "chr1:211-212", "chr10:50-100", "chr2:10-50", "chr2:40-60", "chr20:1-5")
	
	expect_equal(is.sorted.region(regions$a), F )
	expect_equal(is.sorted.region(regions.a.sorted), T )

	})
}
