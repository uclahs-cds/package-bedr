context('vcf2bedpe')

if (check.binary('vcf2bedpe', verbose = TRUE)) {

	test_that('check_vcf2bedpe', {
		for (sv.caller in c('gridss', 'delly', 'manta')){
			vcf.file <- system.file(paste0('extdata/', sv.caller, 'SV.vcf.gz'), package = 'bedr');
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
		});
	}
}
