# adjust coordinates to include confidence interval

adjust.coordinates <- function(df, info_tag, start, end) {
  # convert adjustments to numeric
  df$start <- as.integer(start);
  df$end <- as.integer(end);
  if (!info_tag %in% names(df)) {
    warning(paste0('info tag ', info_tag, ' not found in VCF file. Coordinates are not adjusted'));
    return(list('start' = df$start, 'end' = df$end));
  }
  df[[info_tag]] <- strsplit(df[[info_tag]], ',');
  df$valid_ci <-  lapply(df[[info_tag]], length) == 2;
  df[[info_tag]][!df$valid_ci] <- 0;
  df$ci_start <- do.call(rbind, lapply(df[[info_tag]], as.numeric))[, 1];
  df$ci_end <- do.call(rbind, lapply(df[[info_tag]], as.numeric))[, 2];
  df$start <- df$start + df$ci_start;
  df$start <- ifelse(df$start >= 0, df$start, 0);
  df$end <- df$end + df$ci_end;
  df$end <- ifelse(df$end >= 0, df$end, 0);
  return(list('start' = df$start, 'end' = df$end));
}        