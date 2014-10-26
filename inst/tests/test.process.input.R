context("process.input")

if (check.binary("bedtools", verbose = TRUE)) {

test_that("check input processing i.e. converting to bed and sending to a tmp file", {
	
	regions <- get.example.regions()
	regions$a <- bedr.sort.region(regions$a)

	# good region
	expect_equal(length(process.input(regions$a, verbose = F)), 1);
	expect_equal(attributes(process.input(regions$a, verbose = F)[[1]]), list(is.index=T,is.file=F));
	
	expect_equal(length(process.input(index2bed(regions$a), verbose = F)), 1);
	expect_equal(attributes(process.input(index2bed(regions$a), verbose = F)[[1]]), list(is.index=F,is.file=F));
	
	expect_equal(length(process.input("chrY:24052505-24052506", verbose = F)), 1);
	expect_equal(attributes(process.input("chrY:24052505-24052506", verbose = F)[[1]]), list(is.index=T,is.file=F));


	})

}
