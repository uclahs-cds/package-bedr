# The bedr package is copyright (c) 2014 Ontario Institute for Cancer Research (OICR)
# This package and its accompanying libraries is free software; you can redistribute it and/or modify it under the terms of the GPL
# (either version 1, or at your option, any later version) or the Artistic License 2.0.  Refer to LICENSE for the full license text.
# OICR makes no representations whatsoever as to the SOFTWARE contained herein.  It is experimental in nature and is provided WITHOUT
# WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE OR ANY OTHER WARRANTY, EXPRESS OR IMPLIED. OICR MAKES NO REPRESENTATION
# OR WARRANTY THAT THE USE OF THIS SOFTWARE WILL NOT INFRINGE ANY PATENT OR OTHER PROPRIETARY RIGHT.
# By downloading this SOFTWARE, your Institution hereby indemnifies OICR against any loss, claim, damage or liability, of whatsoever kind or
# nature, which may arise from your Institution's respective use, handling or storage of the SOFTWARE.
# If publications result from research using this SOFTWARE, we ask that the Ontario Institute for Cancer Research be acknowledged and/or
# credit be given to OICR scientists, as scientifically appropriate.


test_that('check in.region', {
	if (check.binary('bedtools', verbose = TRUE)) {	
		regions <- get.example.regions()
		regions$a.lexicon <- bedr.sort.region(regions$a)
		regions$b.lexicon <- bedr.sort.region(regions$b)
		regions$a <- bedr.sort.region(regions$a, method = 'natural')
		regions$b <- bedr.sort.region(regions$b, method = 'natural')
		a.b.overlap <- c(F, T, T, T, T, T, F, F)
		b.a.overlap <- c(F, T, F, F, T, F, F)
		a.b.overlap.pc0 <- c(F, T, T, T, T, T, F, F)
		a.b.overlap.pc5 <- c(F, T, T, T, F, T, F, F)
		a.b.overlap.pc1 <- c(F, F, T, T, F, T, F, F)
		a.b.overlap.lexicon <- c(F, T, T, T, F, T, T, F)
		a.b.overlap.merged <- c(F, T, T, T, T, F, F)

		# bad region
		expect_error(in.region(regions$a, 'cat', verbose = FALSE));
		expect_error(in.region(regions$a, regions$d, verbose = FALSE));

		# raw
		expect_equal(in.region(regions$a, regions$b, verbose = FALSE), a.b.overlap);
	
		# reverse a/b
		expect_equal(in.region(regions$b, regions$a, verbose = FALSE), b.a.overlap);

		# vary the proportion over overlap
		expect_equal(in.region(regions$a, regions$b, proportion.overlap = 0.1, verbose = FALSE), a.b.overlap.pc0);
		expect_equal(in.region(regions$a, regions$b, proportion.overlap = .5, verbose = FALSE), a.b.overlap.pc5);
		expect_equal(in.region(regions$a, regions$b, proportion.overlap = 1, verbose = FALSE), a.b.overlap.pc1);
	
		# lexicon sorting
		expect_equal(in.region(regions$a.lexicon, regions$b.lexicon, method = 'lexicographical', verbose = FALSE), a.b.overlap.sorted);

		# merged
		expect_equal(in.region(bedr.merge.region(regions$a,verbose=F, distance = -1), regions$b, verbose = FALSE), a.b.overlap.merged);

		# %in.region% gives same results
		expect_equal(in.region(regions$a,regions$b, verbose = FALSE), regions$a %in.region% regions$b);
		}
	})
