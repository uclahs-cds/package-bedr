context("in.region")

if (check.binary("bedtools", verbose = TRUE)) {

test_that("check in.region", {
	
	regions <- get.example.regions()
	regions$a <- bedr.sort.region(regions$a)
	regions$b <- bedr.sort.region(regions$b)
	a.b.overlap <- c(F,T,T,T,F,T,T,F)
	b.a.overlap <- c(F,T,F,F,F,T,F)
	a.b.overlap.pc0 <- c(T,T,T,T,T,T,T,F)
	a.b.overlap.pc5 <- c(F,T,T,T,F,F,T,F)
	a.b.overlap.pc1 <- c(F,F,T,T,F,F,T,F)
	a.b.overlap.sorted <- c(F,T,T,T,F,T,T,F)
	a.b.overlap.merged <- c(F,T,T,T,F,T,F)

	# bad region
	expect_error(in.region(regions$a, "cat", verbose = F));
	expect_error(in.region(regions$a, regions$d, verbose = F));

	# raw
	expect_equal(in.region(regions$a, regions$b, verbose = F), a.b.overlap);
	
	# reverse a/b
	expect_equal(in.region(regions$b, regions$a, verbose = F), b.a.overlap);

	# vary the proportion over overlap
	expect_equal(in.region(regions$a, regions$b, proportion.overlap = 0, verbose = F), a.b.overlap.pc0);
	expect_equal(in.region(regions$a, regions$b, proportion.overlap = .5, verbose = F), a.b.overlap.pc5);
	expect_equal(in.region(regions$a, regions$b, proportion.overlap = 1, verbose = F), a.b.overlap.pc1);
	
	# sorted
	expect_equal(in.region(bedr.sort.region(regions$a, verbose = FALSE), regions$b, verbose=F), a.b.overlap.sorted)

	# merged
	expect_equal(in.region(bedr.merge.region(regions$a,verbose=F, distance = -1), regions$b, verbose=F), a.b.overlap.merged)

	# %in.region% gives same results
	expect_equal(in.region(regions$a,regions$b, verbose = F), regions$a %in.region% regions$b)
	
	})
}	
