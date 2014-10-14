context("process.input")

if (check.binary("bedtools", verbose = TRUE)) {

test.that("check input processing i.e. converting to bed and sending to a tmp file", {
	
	regions <- get.example.regions()

	# good region
	expect.equal(length(process.input(regions$a, verbose = F)), 1);
	expect.equal(attributes(process.input(regions$a, verbose = F)[[1]]), list(is.index=T,is.file=F));
	
	expect.equal(length(process.input(index2bed(regions$a), verbose = F)), 1);
	expect.equal(attributes(process.input(index2bed(regions$a), verbose = F)[[1]]), list(is.index=F,is.file=F));
	
	expect.equal(length(process.input("chrY:24052505-24052506", verbose = F)), 1);
	expect.equal(attributes(process.input("chrY:24052505-24052506", verbose = F)[[1]]), list(is.index=T,is.file=F));


	})

}
