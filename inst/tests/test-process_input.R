context("process_input")

if (check_binary("bedtools")) {

test_that("check input processing i.e. converting to bed and sending to a tmp file", {
	
	regions <- get_example_regions()

	# good region
	expect_equal(length(process_input(regions$a, verbose = F)), 1);
	expect_equal(attributes(process_input(regions$a, verbose = F)[[1]]), list(is.index=T,is.file=F));
	
	expect_equal(length(process_input(index2bed(regions$a), verbose = F)), 1);
	expect_equal(attributes(process_input(index2bed(regions$a), verbose = F)[[1]]), list(is.index=F,is.file=F));
	
	expect_equal(length(process_input("chrY:24052505-24052506", verbose = F)), 1);
	expect_equal(attributes(process_input("chrY:24052505-24052506", verbose = F)[[1]]), list(is.index=T,is.file=F));


	})

}
