context("is_merged_region")

if (check_binary("bedtools", verbose = FALSE)) {

test_that("correctly identifies if regions are merged", {	
	
	regions <- get_example_regions()
	regions.a.merged <- c("chr1:10-100",  "chr1:101-210", "chr1:211-212", "chr10:50-100", "chr2:10-60", "chr20:1-5")
	regions.a.merged.pc0 <- c("chr1:10-100",  "chr1:101-210", "chr1:211-212", "chr10:50-100", "chr2:10-60", "chr20:1-5")
	
	expect_equal(is_merged_region(regions$a), F )
	expect_equal(is_merged_region(regions.a.merged), T )


	})

}
