context("convert2bed")

if (check_binary("bedtools")) {

test_that("check converting a region into bed file including file type checking and region verification", {
	
	regions <- get_example_regions()
	a.bed <- index2bed(regions$a)
	b.bed <- index2bed(regions$b)

	# bad region
	expect_error(convert2bed("meow", verbose = F))

	# good region
	expect_equivalent(convert2bed(regions$a, verbose = F), a.bed);
	expect_equivalent(convert2bed(regions$b, verbose = F), b.bed);
	expect_equivalent(convert2bed("chrY:24052505-24052506", verbose = F), data.frame(chr="chrY", start=24052505, end=24052506, stringsAsFactors = FALSE));


	})

}
