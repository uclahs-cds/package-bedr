context("in_region")

if (check_binary("bedtools", verbose = FALSE)) {

test_that("check in_region", {
	
	regions <- get_example_regions()
	a.b.overlap <- c(F,T,T,T,T,F,T,F )
	b.a.overlap <- c(F,T,F,F,F,T,F )
	a.b.overlap_pc0 <- c(T,T,T,T,T,T,T,F)
	a.b.overlap_pc5 <- c(F,T,T,T,F,F,T,F)
	a.b.overlap_pc1 <- c(F,F,T,T,F,F,T,F)
	a.b.overlap_sorted <- c(F,T,T,T,F,T,T,F)
	a.b.overlap_merged <- c(F,T,T,T,F,T,F)

	# bad region
	expect_error(in_region(regions$a, "cat", verbose = F));
	expect_error(in_region(regions$a, regions$d, verbose = F));

	# raw
	expect_equal(in_region(regions$a, regions$b, verbose = F), a.b.overlap);
	
	# reverse a/b
	expect_equal(in_region(regions$b, regions$a, verbose = F), b.a.overlap);

	# vary the proportion over overlap
	expect_equal(in_region(regions$a, regions$b, proportion.overlap = 0, verbose = F), a.b.overlap_pc0);
	expect_equal(in_region(regions$a, regions$b, proportion.overlap = .5, verbose = F), a.b.overlap_pc5);
	expect_equal(in_region(regions$a, regions$b, proportion.overlap = 1, verbose = F), a.b.overlap_pc1);
	
	# sorted
	expect_equal(in_region(sort_region(regions$a, verbose = FALSE), regions$b, verbose=F), a.b.overlap_sorted)

	# merged
	expect_equal(in_region(merge_region(regions$a,verbose=F, distance = -1), regions$b, verbose=F), a.b.overlap_merged)

	# %in.region% gives same results
	expect_equal(in_region(regions$a,regions$b, verbose = F), regions$a %in_region% regions$b)
	
	})
}	
