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

test_that('check that index to bed conversion is working', {

	regions <- get.example.regions();
	chr.dat <- c('chr1',  'chr1',  'chr1',  'chr1',  'chr2',  'chr10', 'chr2',  'chr20');
	start.dat <- c(10, 101, 200, 211, 10, 50, 40, 1);
	end.dat <- c(100, 200, 210, 212, 50, 100, 60, 5);
	region.a.bed <- data.frame(chr = chr.dat, start = start.dat, end = end.dat, stringsAsFactors = FALSE);

	expect_equal(index2bed(regions$a), region.a.bed);

	})

