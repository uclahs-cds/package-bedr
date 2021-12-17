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


test_that('check converting a region into bed file including file type checking and region verification', {
	if (check.binary('bedtools', verbose = TRUE)) {	
		regions <- get.example.regions()
		regions$a <- bedr.sort.region(regions$a)
		regions$b <- bedr.sort.region(regions$b)
		a.bed <- index2bed(regions$a)
		b.bed <- index2bed(regions$b)

		# bad region
		expect_error(convert2bed('meow', verbose = FALSE))

		# good region
		# expect_equivalent(convert2bed(regions$a, verbose = FALSE), a.bed);
		# expect_equivalent(convert2bed(regions$b, verbose = FALSE), b.bed);
		# expect_equivalent(convert2bed('chrY:24052505-24052506', verbose = FALSE), data.frame(chr = 'chrY', start = 24052505, end = 24052506, stringsAsFactors = FALSE));
		expect_equal(convert2bed(regions$a, verbose = FALSE), a.bed, ignore_attr = TRUE);
		expect_equal(convert2bed(regions$b, verbose = FALSE), b.bed, ignore_attr = TRUE);
		expect_equal(convert2bed('chrY:24052505-24052506', verbose = FALSE), data.frame(chr = 'chrY', start = 24052505, end = 24052506, stringsAsFactors = FALSE), ignore_attr = TRUE);
		}
	})
