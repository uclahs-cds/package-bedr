download_datasets <- function(datasets = "all", data_dir = paste0(Sys.getenv("HOME"),"/bedr/data")) {

	if (datasets == "all") {
		datasets <- c("refgene","hg19","b37","hugo", "cosmic","clinvar", "agilent", "nimblegen");
		}
	
	old_dir <- getwd();
	setwd(data_dir);

	# get the fasta files from the broads ftp.  thank you!
	if ("hg19" %in% datasets && !file.exists(paste0(data_dir,"/ucsc.hg19.fasta.gz"))) {
		download.file("ftp://ftp.broadinstitute.org/bundle/2.8/hg19/ucsc.hg19.fasta.gz",destfile="ucsc.hg19.fasta.gz", extra="--user gsapubftp-anonymous", method = "wget")
		download.file("ftp://ftp.broadinstitute.org/bundle/2.8/hg19/ucsc.hg19.fasta.fai.gz",destfile="ucsc.hg19.fasta.fai.gz", extra="--user gsapubftp-anonymous", method = "wget")
		}

	if ("b37" %in% datasets && !file.exists(paste0(data_dir, "/human_g1k_v37.fasta.gz"))) {
		download.file("ftp://ftp.broadinstitute.org/bundle/2.8/b37/human_g1k_v37.fasta.gz",destfile="human_g1k_v37.fasta.gz", extra="--user gsapubftp-anonymous", method = "wget")
		download.file("ftp://ftp.broadinstitute.org/bundle/2.8/b37/human_g1k_v37.fasta.fai.gz",destfile="ucsc.hg19.fasta.fai.gz", extra="--user gsapubftp-anonymous", method = "wget")
		}

	# get the gene data from the 
	if ("refgene" %in% datasets && !file.exists(paste0(data_dir, "/refGene.txt.gz"))) {
		download.file("http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/refGene.txt.gz", destfile="refGene.txt.gz");
		download.file("http://hgdownload.soe.ucsc.edu/goldenPath/hg19/database/refGene.sql", destfile="refGene.sql");
		}
	
	# parse refgene
	if ("refgene" %in% datasets && !file.exists(paste0(data_dir, "/gene_regions.txt"))) {
		refgene    <- query_ucsc(paste0(data_dir, "/refGene.txt.gz"));
		# only select pr coding genes
		refgene_nm <- refgene[grepl("^NM",refgene$name),c("chrom","txStart","txEnd","name2","strand")]
		# only include canonical chr
		chr <- paste0("chr", c(1:22,"X","Y"));
		refgene_nm <- refgene_nm[refgene_nm[,1] %in% chr,]
		# sort and merge
		refgene_nm <- snm(refgene_nm,check.chr = FALSE);
		# remove genes with multiple positions
		duplicated.gene <- duplicated(refgene_nm[,4]) | duplicated(rev(refgene_nm[,4]));
		refgene_nm <- refgene_nm[!duplicated.gene,];
		write.table(refgene_nm, paste0(data_dir, "/gene_regions.txt"), sep = "\t", quote = FALSE, row.names = FALSE);
		}

	# hugo gene names with alias's
	if ("hugo" %in% datasets && !file.exists(paste0(data_dir, "/hugo_protein_coding_genes.txt.gz"))) {
		download.file("ftp://ftp.ebi.ac.uk/pub/databases/genenames/locus_groups/protein-coding_gene.txt.gz", destfile = "hugo_protein_coding_genes.txt.gz");
		}
	
	# cosmic
	if ("cosmic" %in% datasets && !file.exists(paste0(data_dir, "/CosmicCodingMuts_v68.vcf.gz"))) {
		download.file("ftp://ngs.sanger.ac.uk/production/cosmic/CosmicCodingMuts_v68.vcf.gz", destfile ="CosmicCodingMuts_v68.vcf.gz");
		download.file("ftp://ngs.sanger.ac.uk/production/cosmic/CosmicNonCodingVariants_v68.vcf.gz", destfile = "CosmicNonCodingVariants_v68.vcf.gz");
		}

	# clinvar
	if ("clinvar" %in% datasets && !file.exists(paste0(data_dir, "/clinvar.vcf.gz"))) {
		download.file("ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf/clinvar_00-latest.vcf.gz", destfile = "clinvar.vcf.gz");
		download.file("ftp://ftp.ncbi.nlm.nih.gov/pub/clinvar/vcf/clinvar_00-latest.vcf.gz.tbi", destfile = "clinvar.vcf.gz.tbi");
		}

	setwd(old_dir)

	return(0);
	}
