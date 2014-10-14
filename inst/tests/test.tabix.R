context("tabix")

if (check.binary("tabix")) {

test_that("check tabix", {
	vcf <- system.file("extdata/CosmicCodingMuts_v66_20130725_ex.vcf.gz", package = "bedr");
	regions <- get.example.regions()
	a.nochr <- gsub("^chr", "", regions$a)

	b <- c("chr1:10-100000","chr10:100-100000")
	b.nochr <- c("1:10-100000","10:100-100000")

	b.nochr.matrix <- index2bed(b.nochr);

	# bad region
	expect_error(tabix("meow", vcf, verbose = F));

	# no chr
	expect_error(tabix(a.nochr, vcf, verbose = F));

	# missing file
	expect_error(tabix(a.nochr, "meow", check.chr = FALSE, verbose = F));

	# check the length of output
	expect_equal(nrow(tabix(a.nochr, vcf, verbose = F, check.chr = FALSE)), NULL);
	expect_equal(nrow(tabix(b.nochr, vcf, verbose = F, check.chr = FALSE)), 6);
	
	# check the header is included
	expect_equal(colnames(tabix(b.nochr, vcf, verbose = F, check.chr = FALSE)), c("CHROM", "POS", "ID", "REF", "ALT", "QUAL", "FILTER", "INFO")); 

	# check header is correct length
	expect_equal(length(attributes(tabix(b.nochr, vcf, verbose = F, check.chr = FALSE))$header), 13);
	})
}
