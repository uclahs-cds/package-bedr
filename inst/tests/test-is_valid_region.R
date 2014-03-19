context("is_valid_region")

test_that("check if region input is valid", {
	
	regions <- get_example_regions()

	# good region
	expect_equal(is_valid_region(regions$a, verbose = FALSE), c(T,T,T,T,T,T,T,T));
	expect_equal(is_valid_region("chrY:24052505-24052506", verbose = FALSE), T);

	# bad region format (region d has bad)
	expect_equal(is_valid_region(regions$d, verbose = FALSE), c(T,F,T,F,F,F,F,F));
	expect_error(is_valid_region(regions$d, throw.error = TRUE, verbose = FALSE));

	})
