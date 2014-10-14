context("convert2bed")

if (check.binary("bedtools", verbose = TRUE)) {

test.that("check converting a region into bed file including file type checking and region verification", {
	
	regions <- get.example.regions()
	a.bed <- index2bed(regions$a)
	b.bed <- index2bed(regions$b)

	# bad region
	expect.error(convert2bed("meow", verbose = F))

	# good region
	expect.equivalent(convert2bed(regions$a, verbose = F), a.bed);
	expect.equivalent(convert2bed(regions$b, verbose = F), b.bed);
	expect.equivalent(convert2bed("chrY:24052505-24052506", verbose = F), data.frame(chr="chrY", start=24052505, end=24052506, stringsAsFactors = FALSE));


	})

}
