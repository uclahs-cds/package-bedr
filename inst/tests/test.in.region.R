context("in.region")

if (check.binary("bedtools", verbose = FALSE)) {

test.that("check in.region", {
	
	regions <- get.example.regions()
	a.b.overlap <- c(F,T,T,T,T,F,T,F )
	b.a.overlap <- c(F,T,F,F,F,T,F )
	a.b.overlap.pc0 <- c(T,T,T,T,T,T,T,F)
	a.b.overlap.pc5 <- c(F,T,T,T,F,F,T,F)
	a.b.overlap.pc1 <- c(F,F,T,T,F,F,T,F)
	a.b.overlap.sorted <- c(F,T,T,T,F,T,T,F)
	a.b.overlap.merged <- c(F,T,T,T,F,T,F)

	# bad region
	expect.error(in.region(regions$a, "cat", verbose = F));
	expect.error(in.region(regions$a, regions$d, verbose = F));

	# raw
	expect.equal(in.region(regions$a, regions$b, verbose = F), a.b.overlap);
	
	# reverse a/b
	expect.equal(in.region(regions$b, regions$a, verbose = F), b.a.overlap);

	# vary the proportion over overlap
	expect.equal(in.region(regions$a, regions$b, proportion.overlap = 0, verbose = F), a.b.overlap.pc0);
	expect.equal(in.region(regions$a, regions$b, proportion.overlap = .5, verbose = F), a.b.overlap.pc5);
	expect.equal(in.region(regions$a, regions$b, proportion.overlap = 1, verbose = F), a.b.overlap.pc1);
	
	# sorted
	expect.equal(in.region(sort.region(regions$a, verbose = FALSE), regions$b, verbose=F), a.b.overlap.sorted)

	# merged
	expect.equal(in.region(merge.region(regions$a,verbose=F, distance = -1), regions$b, verbose=F), a.b.overlap.merged)

	# %in.region% gives same results
	expect.equal(in.region(regions$a,regions$b, verbose = F), regions$a %in.region% regions$b)
	
	})
}	
