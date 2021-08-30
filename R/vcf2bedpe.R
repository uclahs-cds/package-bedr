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
  temp.vcf <- read.vcf(file.list[i], split.info = TRUE)$vcf;
  
  # focus on SVs
  temp.vcf <- temp.vcf[which(temp.vcf$SVTYPE %in% VALID.SV.TYPES), ];
  
  # convert to zero-based coordinates
  temp.vcf$POS <- temp.vcf$POS - 1;
  
  vcf.list[[names(file.list)[i]]] <- temp.vcf
}

## vcf to bedpe
# CHROM_A START_A END_A CHROM_B START_B END_B ID QUAL STRAND_A STRAND_B INFO_A INFO_B
# 1	23559191	23559192	1	23559244	23559245	DEL_gridss2fb_2966o	2355.69	+	-


BL.vcf <- vcf.list[['BL']]
LCR.vcf <- vcf.list[['LCR']]
LCR.vcf$ID <- gsub('(.*_)(.*_.*)', '\\2', LCR.vcf$ID)

callerA.bed <- vcf2bed(read.vcf(file.list[1], split.info = TRUE))

## get pairs

x = apply(LCR.vcf[1:5,], 2, function(x) print(x['SVTYPE']))
x = BL.vcf[5,]

# for BL
converter_vcf2bedpe <- function(var1, var2 = NULL, alt = FALSE) {
  x <- var1
  y <- ifelse(is.null(var2), var1, var2)
  
  x$END <- ifelse(is.na(x$END), x$START, x$END)
  y$END <- ifelse(is.na(y$END), y$START, y$END)
  
  coordsA <- adjust_coordinates(x, 'CIPOS', y$POS, x$POS)
  coordsB <- adjust_coordinates(y, 'CIEND', y$END, y$END)
  strandA <- '+'
  strandB <- '-'
  
  name <- x$ID
  if ('EVENT' %in% names(x)) { 
    name  <- x$EVENT 
  } else if ('MATEID' %in% names(x) & grepl('^Manta', x$ID)) {
    name <- str_split(x$ID , ':.$')
  }
  
  if (!is.null(x$MATESTRAND) & !is.na(x$MATESTRAND)) { strandB <- x$MATESTRAND }
  if (!is.null(y$MATESTRAND) & !is.na(y$MATESTRAND)) { strandA <- y$MATESTRAND }
  
  df_row <- data.frame(CHROM_A = x$CHROM, START_A = coordsA[1] , END_A = coordsA[2],
                       CHROM_B = y$CHROM, START_B = coordsB[1], END_B = coordsB[2],
                       ID = name, QUAL = var1$QUAL, STRAND_A = strand_A, STRAND_B = strand_B)
}

vcf2bedpe <- function(vcfDF, bedpe_file) {
  bnds <- list()
  sec_bnds <- list()
  
  for (i in 1:nrow(vcfDF)) {
    x <- vcfDF[1, ];
    
    
    if (x$SVTYPE != 'BND' & is.na(x$MATEID)) {
      bedpe_row <- converter_vcf2bedpe(var1 = x)
    }
  }
}
  
  
  
  
  
  # simple breakpoint with no MATEID 
  if (x$SVTYPE != 'BND' & is.na(x$MATEID)) { 
    # what if CIPOS DNE?
    #coordsA <- adjust_coordinates(x, 'CIPOS', x$POS, x$POS)
    #coordsB <- adjust_coordinates(x, 'CIEND', x$END, x$END)
    
    #bedpe_row <- data.frame(CHROM_A = x$CHROM, START_A = coordsA[1] , END_A = coordsA[2],
    #                       CHROM_B = x$CHR2, START_B = coordsB[1], END_B = coordsB[2],
    #                        ID = x$ID, QUAL = x$QUAL, STRAND_A = '+', STRAND_B = '-')
  
  } else if (x$SVTYPE == 'BND' & !is.na(x$MATEID)) { 
    mate_id <- x$MATEID
    if (mate_id %in% bnds) {
      mate <- bnds[['mate_id']];
      bedpe_row <- convert_row_vcf2bedpe(mate, x);
    } else if (mate_id %in% sec_bnds) {
      mate <- sec_bnds[['mate_id']];
      bedpe_row <- convert_row_vcf2bedpe(x, mate);
    } else { # make sure var1 is smaller that var2 - coordinates-wise
      intX <- as.integer(paste0(gsub('chr', '', x$CHROM), x$POS));
      intY <- as.integer(paste0(gsub('chr', '', x$CHROM), y$POS));
      if (intX < intY) {
        bnds[[x$ID]] <- x
      } else{
        sec_bnds[[x$ID]] <- x
      }
    }
    
    
    
    bedpe_row <- data.frame(CHROM_A = x$CHROM, START_A = coordsA[1] , END_A = coordsA[2],
                            CHROM_B = x$CHR2, START_B = coordsB[1], END_B = coordsB[2],
                            ID = x$ID, QUAL = x$QUAL, STRAND_A = '+', STRAND_B = '-')
    

    
  } else if () { #check ALT field
    
  }
}

adjust_coordinates <- function(x, info_tag, start, end) {
  start <- integer(start)
  end <- integer(end)
  
  span <- as.integer(unlist(str_split(x[['info_tag']], ",")))
  if (length(span) != 2) {
    warnings(paste('Invalid value for', info_tag, 'tag. Require 2 values to adjust coordinates', sep = ' '))
    return(c(start, end))
  } else {
    return(c(max(start + span[1],0 ), max(end + span[2], 0)))
  }
}


# parse ALT string
parse_alt_string <- function(alt_string) {
  coords <- unlist(str_split(alt_string, '\\[|\\]'))[2] %>% str_split(':')
  if (grepl('].*]', alt_string)) {
    strand <- '+'
  } else if (grepl('[.*[', alt_string)) {
    strand <- '-'
  } else {stop(paste0('Unexpected ALT field: ', alt_string)) }

  chrom <- as.integer(gsub('chr', '', coords[[1]][1]))
  pos <- as.integer(coords[[1]][2])

  return(list('chrom' = chrom, 'pos' = pos, 'strand' = strand ))
}


### DATAFRAME APPROACH
vcf2bedpe <- function(x, filename = NULL, header = FALSE, other = NULL, verbose = TRUE) {
  catv("CONVERT VCF TO BEDPE\n")
  CHROM_A = x$CHROM, START_A = coordsA[1] , END_A = coordsA[2],
  CHROM_B = x$CHR2, START_B = coordsB[1], END_B = coordsB[2],
  ID = x$ID, QUAL = x$QUAL, STRAND_A = '+', STRAND_B = '-')
  if (!is.null(attr(x, "vcf")) && attr(x, "vcf") && all(names(x) == c("header","vcf"))) {
    x <- x$vcf;
  }
  else {
    catv(" * This is not an vcf!\n")
    stop();
  }
  
  x$CHROM <- gsub('chr', '', x$CHROM)
  
  simple_bp <- subset(x, SVTYPE != 'BND' & is.na(x$MATEID))
  
  if (nrow(simple_bp > 0)){
    print('PROCESSING SIMPLE BREAKENDS \n')
    coordsA <- adjust_coordinates(simple_bp, 'CIPOS', simple_bp$POS, simple_bp$POS)
    coordsB <- adjust_coordinates(simple_bp, 'CIEND', simple_bp$END, simple_bp$END)
    name <- get_name(simple_bp)
    
    simple_bedpe <- data.frame(CHROM_A = simple_bp$CHROM, 
                               START_A = coordsA$start,
                               END_A = coordsA$end,
                               CHROM_B = gsub('chr', '', simple_bp$CHR2), 
                               START_B = coordsB$start,
                               END_B = coordsB$end,
                               ID = name,
                               QUAL = simple_bp$QUAL,
                               STRAND_A = '+',
                               STRAND_B = '_',
                               SVTYPE = simple_bnd$SVTYPE)
  }
  
  bnd_bp <- subset(x, SVTYPE == 'BND')
  if (nrow(bnd_bp > 0)) {
    print('PROCESSING BND BREAKENDS \n')
    
    rownames(bnd_bp) <- bnd_bp$ID
    
    if ('MATEID' %in% names(bnd_bp)) {
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
  return(bedpe_df)
}

remove_duplicate_bnds <- function(bedpe) {
  bedpe2 <- subset(bedpe, CHROM_A < CHROM_B)
  bedpe3 <- subset(bedpe, CHROM_A == CHROM_B) %>%
    subset(bedpe, START_A < START_B)
  # check if same chr and same start exist
  same <- subset(bedpe, CHROM_A == CHROM_B & START_A == START_B)
  if (nrow(same) != 0) {
    warning('The following rows have the same CHROM and START value \n')
    print(same)
  }
  return(rbind(bedpe2, bedpe3))
}

get_strand<- function(df) {
  strand <- '+'
  if ('STRAND' %in% names(df)) {
    strand <- df$STRAND
  } else if any(grepl('\\]|\\[', df$ALT)) {
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
    name <- do.call(rbind, str_split(z$ID , ':.$'))[,1]
  } else if (any((grepl('_[12]$', name))) {
    name <- do.call(rbind, gsub('_[12]$', '', z$ID))[,1]
  } 
  return(name)
}

adjust_coordinates <- function(df, info_tag, start, end) {
  # convert adjustments to numeric
  df$start <- df[[start_col]]
  df$end <- df[[end_col]]
  
  if (!info_tag %in% names(x)) {
    warning(paste0('info tag ', info_tag, ' not found in VCF file. Coordinates are not adjusted'))
    return(list('start' = df$start, 'end' = df$end))
  }
  
  df[[info_tag]] <- str_split(df[[info_tag]], ',')
  df$valid_ci <-  lapply(df[[info_tag]], length) == 2
  
  df[[info_tag]][!df$valid_ci] <- 0

  df$ci_start <- do.call(rbind, lapply(df[[info_tag]], as.numeric))[,1]
  df$ci_end <- do.call(rbind, lapply(df[[info_tag]], as.numeric))[,2]
  
  df$start <- df[[start_col]] + df$ci_start
  df$start <- ifelse(df$start >= 0, df$start, 0)
  df$end <- df[[end_col]] + df$ci_end
  df$end <- ifelse(df$end >= 0, df$end, 0)
  
  return(list('start' = df$start, 'end' = df$end))
}                           
     
bedpe.list <- list()
for (i in 1:length(vcf.list)) {
  bedpe.list[[names(vcf.list)[i]]] <- vcf2bedpe(vcf.list[[i]])
  
}





