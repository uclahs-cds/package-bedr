context("is.valid.region")

test.that("check if region input is valid", {
	
	regions <- get.example.regions()

	# good region
	expect.equal(is.valid.region(regions$a, verbose = FALSE), c(T,T,T,T,T,T,T,T));
	expect.equal(is.valid.region("chrY:24052505-24052506", verbose = FALSE), T);

	# bad region format (region d has bad)
	expect.equal(is.valid.region(regions$d, verbose = FALSE), c(T,F,T,F,F,F,F,F));
	expect.error(is.valid.region(regions$d, throw.error = TRUE, verbose = FALSE));

	})
