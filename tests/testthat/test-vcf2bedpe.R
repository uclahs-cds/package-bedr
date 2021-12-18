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

test_that('check_vcf2bedpe', {
  	for (sv.caller in c('gridss', 'delly', 'manta')) {
		vcf.file <- testthat::test_path(paste0('data/', sv.caller, 'SV.vcf.gz'));
  		vcf <- read.vcf(vcf.file, split.info = TRUE);
  		bedpe <- vcf2bedpe(vcf);
  
  		# check bedpe is not empty
  		expect_equal((nrow(bedpe) > 0), TRUE);
  
  		# check the header is included
  		expect_equal(colnames(bedpe), c('CHROM_A', 'START_A', 'END_A', 'CHROM_B', 'START_B', 'END_B', 'ID', 'QUAL', 'STRAND_A', 'STRAND_B', 'SVTYPE')); 
  
  		# if SVTYPE == BND, must have MATEID
  		if (sv.caller == 'gridss') {
  			vcf$vcf <- subset(vcf$vcf, select = -MATEID);
  			expect_error(vcf2bedpe(vcf));
  		}
    	# expect error if vcf is unpacked 
    	expect_error(vcf2bedpe(vcf$vcf));
    
    	# expect error if VCF doesnt have SVTYPE column
    	vcf$vcf <- subset(vcf$vcf, select = -SVTYPE);
    	expect_error(vcf2bedpe(vcf));	
    	}
    })
  
