library(devtools)

setwd('/projects/rmorin_scratch/hwinata/test_bedr/public-R-bedr/')
devtools::install()

library('bedr')

# add bedtools, bedops and tabix to PATH variable
Sys.setenv(PATH = paste('/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin',
                        '/projects/clc/usr/anaconda/workflow_prototype/bin',
                        '/projects/clc/usr/anaconda/5.1.0/bin',
                        sep = ':'))
if (check.binary("bedtools")) {
  
  # get example regions
  index <- get.example.regions();
  a <- index[[1]];
  b <- index[[2]];
  
  # region validation
  is.a.valid  <- is.valid.region(a);
  is.b.valid  <- is.valid.region(b);
  a <- a[is.a.valid];
  b <- b[is.b.valid];
  
  # print
  cat(" REGION a: ", a, "\n");
  cat(" REGION b: ", b, "\n");
}


VALID.SV.TYPES <- c('BND', 'CNV', 'DEL', 'DUP', 'INS', 'INV');
POSITION.COLUMNS <- c('CHROM', 'POS', 'END');

manta.file <-  '/projects/rmorin_scratch/hwinata/test_bedr/data/somaticSV.vcf'
BL.test.file <- '/projects/rmorin_scratch/hwinata/test_bedr/data/BL_test1.vcf'
LCR.test.file <- '/projects/rmorin_scratch/hwinata/test_bedr/data/LCR_test.vcf'

file.list <- c('manta' = manta.file,
               'BL' = BL.test.file,
               'LCR' = LCR.test.file)
vcf.list <- list()

for (i in 1:length(file.list)) {
  # read the VCF file
  temp.vcf <- read.vcf(file.list[i], split.info = TRUE)
  
  # focus on SVs
  #temp.vcf <- temp.vcf[which(temp.vcf$SVTYPE %in% VALID.SV.TYPES), ];
  
  # convert to zero-based coordinates
  temp.vcf$vcf$POS <- temp.vcf$vcf$POS - 1;
  
  vcf.list[[names(file.list)[i]]] <- temp.vcf
}


### DATAFRAME APPROACH ====
vcf2bedpe <- function(x, filename = NULL, header = FALSE, other = NULL, verbose = TRUE) {
  catv("CONVERT VCF TO BEDPE\n")
  
  if (!is.null(attr(x, "vcf")) && attr(x, "vcf") && all(names(x) == c("header","vcf"))) {
    x <- x$vcf;
  }
  else {
    catv(" * This is not an vcf!\n")
    stop();
  }
  
  x$CHROM <- gsub('chr', '', x$CHROM)
  
  if (!'SVTYPE' %in% names(x)) {
    stop('SVTYPE column must exist in VCF file')
  }
  simple_bp <- subset(x, SVTYPE != 'BND' & is.na(x$MATEID))
  
  if (nrow(simple_bp) > 0) {
    print('PROCESSING SIMPLE BREAKENDS')
    coordsA <- adjust_coordinates(simple_bp, 'CIPOS', simple_bp$POS, simple_bp$POS)
    coordsB <- adjust_coordinates(simple_bp, 'CIEND', simple_bp$END, simple_bp$END)
    name <- get_name(simple_bp)
    
    if (!'CHR2' %in% names(simple_bp)) {
      simple_bp$CHR2 <- simple_bp$CHROM
    }
    
    simple_bedpe <- data.frame(CHROM_A = simple_bp$CHROM, 
                               START_A = coordsA$start,
                               END_A = coordsA$end,
                               CHROM_B = gsub('chr', '', simple_bp$CHR2), 
                               START_B = coordsB$start,
                               END_B = coordsB$end,
                               ID = name,
                               QUAL = ifelse(is.na(simple_bp$QUAL), '.', simple_bp$QUAL),
                               STRAND_A = rep('+', length(simple_bp$CHROM)),
                               STRAND_B = rep('_', length(simple_bp$CHR2)),
                               SVTYPE = simple_bp$SVTYPE)
  }
  
  bnd_bp <- subset(x, SVTYPE == 'BND')
  if (nrow(bnd_bp > 0)) {
    print('PROCESSING BND BREAKENDS')
    
    rownames(bnd_bp) <- bnd_bp$ID
    
    if ('MATEID' %in% names(bnd_bp)) {
      bnd_bp <- subset(bnd_bp, !is.na(MATEID))
      mates <- bnd_bp[bnd_bp$MATEID,]

      coordsA <- adjust_coordinates(bnd_bp, 'CIPOS', bnd_bp$POS,  bnd_bp$POS)
      coordsB <- adjust_coordinates(bnd_bp, 'CIPOS', mates$POS, mates$POS)
      name <- get_name(bnd_bp)
      strandA <- get_strand(bnd_bp)
      strandB <- get_strand(mates)
      svtype <- ifelse(!is.null(bnd_bp$SIMPLE_TYPE), bnd_bp$SIMPLE_TYPE, 'BND')

      bnd_bedpe <- data.frame(CHROM_A = bnd_bp$CHROM, START_A = coordsA$start, END_A = coordsA$end,
                              CHROM_B = mates$CHROM, START_B = coordsB$start, END_B = coordsB$end,
                              ID = name, QUAL = bnd_bp$QUAL, STRAND_A = strandA, STRAND_B = strandB,
                              SVTYPE = svtype)
      bnd_bedpe <- remove_duplicate_bnds(bnd_bedpe) 
    } else {
      stop('MATEID is not present in the VCF file INFO field')
    }
  }
  
  bedpe_df <- rbind(simple_bedpe, bnd_bedpe) 
  bedpe_df <- bedpe_df[with(bedpe_df, order(CHROM_A, START_A)), ]
  
  if (!is.null(filename)) {
    write.table(bedpe_df, 
                file = filename,
                col.names = TRUE, 
                row.names = FALSE, 
                sep = '\t',  
                quote = FALSE
                )
  }
  return(bedpe_df)
}

remove_duplicate_bnds <- function(bedpe) {
  bedpe$CHR_A_INT <- as.integer(factor(bedpe$CHROM_A, level = unique(bedpe$CHROM_A)))
  bedpe$CHR_B_INT <- as.integer(factor(bedpe$CHROM_B, level = unique(bedpe$CHROM_B)))
  
  bedpe2 <- subset(bedpe, CHR_A_INT < CHR_B_INT)
  bedpe3 <- subset(bedpe, CHR_A_INT == CHR_B_INT & START_A < START_B)
  #bedpe3 <- subset(bedpe, CHROM_A == CHROM_B) %>%
  #  subset(bedpe, START_A < START_B)
  # check if same chr and same start exist
  same <- subset(bedpe, CHROM_A == CHROM_B & START_A == START_B)
  if (nrow(same) != 0) {
    warning('The following rows have the same CHROM and START value \n')
    print(same)
  }
  return(subset(bedpe2, select = -c(CHR_A_INT, CHR_B_INT)))
  #return(rbind(bedpe2, bedpe3))
}

get_strand <- function(df) {
  strand <- rep('+', nrow(df))
  if ('STRAND' %in% names(df)) {
    strand <- df$STRAND
  } else if (any(grepl('\\]|\\[', df$ALT))) {
    strand[grepl('\\[.*\\[', df$ALT)] <- '-'
  } else {
    warning('STRAND information is not recorded in INFO:STRAND or ALT field. Returning default: + ')
  }
  return(strand)
} 


get_name <- function(df) {
  name <- df$ID
  if ('EVENT' %in% names(df)) {
    name <- df$EVENT
  } else if (any(grepl('^Manta', name))) {
    name <- do.call(rbind, str_split(df$ID , ':.$'))[,1]
  } else if (any(grepl('_[12]$', name))) {
    name <- gsub('_[12]$', '', df$ID)
  }
  return(name)
}


adjust_coordinates <- function(df, info_tag, start, end) {
  # convert adjustments to numeric
  df$start <- as.integer(start)
  df$end <- as.integer(end)
  
  if (!info_tag %in% names(df)) {
    warning(paste0('info tag ', info_tag, ' not found in VCF file. Coordinates are not adjusted'))
    return(list('start' = df$start, 'end' = df$end))
  }
  
  df[[info_tag]] <- str_split(df[[info_tag]], ',')
  df$valid_ci <-  lapply(df[[info_tag]], length) == 2
  
  df[[info_tag]][!df$valid_ci] <- 0

  df$ci_start <- do.call(rbind, lapply(df[[info_tag]], as.numeric))[,1]
  df$ci_end <- do.call(rbind, lapply(df[[info_tag]], as.numeric))[,2]
  
  df$start <- df$start + df$ci_start
  df$start <- ifelse(df$start >= 0, df$start, 0)
  df$end <- df$end + df$ci_end
  df$end <- ifelse(df$end >= 0, df$end, 0)
  
  return(list('start' = df$start, 'end' = df$end))
}                           
     
bedpe.list <- list()

for (i in 1:length(vcf.list)) {
  print(paste0('Running ', names(vcf.list)[i]))
  if (names(vcf.list)[i] == 'manta') {
    vcf.list[[i]]$vcf$SVTYPE <- gsub('(Manta)([A-Z]{3})(:.*)', '\\2', vcf.list[[i]]$vcf$ID)
  }
  bedpe.list[[names(vcf.list)[i]]] <- vcf2bedpe(vcf.list[[i]])
}




