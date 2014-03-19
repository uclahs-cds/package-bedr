# vcf2bed
# subtract one position for start
# add length of alt as end
# if - as ref then need to go to fasta


vcf2bed <- function(x, filename = NULL, other = NULL) {

	if (attr(x, "vcf") & length(x)  == 2) {
		x <- x$vcf;
		}


	chr   <- x$CHROM;
	start <- x$POS-1;
	end   <- x$POS+nchar(x$ALT)-1;

	if (length(other) == 1 && other %in% c("all","ALL")) {other <- colnames(x)[colnames(x) %in% c("CHROM","POS")]}

	if (!is.null(other)) {
		
		if (is.data.table(x)) {
			bed <- data.frame(chr = chr, start = start, end = end, x[,other, with = FALSE ]);
			}
		else {
			bed <- data.frame(chr = chr, start = start, end = end, x[,other]);
			}
		}
	else {
		bed <- data.frame(chr = chr, start = start, end = end)
		}

	if (!is.null(filename)) {
		write.table(bed,filename,row.names = FALSE, sep = "\t", quote = FALSE);
		}
	else {
		return(bed);
		}

	}

