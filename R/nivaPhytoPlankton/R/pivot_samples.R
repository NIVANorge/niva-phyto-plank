#' Pivot Samples to Wide Format
#' This function pivots a data frame of samples and phytoplankton to wide format.
#' Each unique sample of date and depth range becomes a separate column.
#' The BIO_VOLUME values are summed if there are multiple entries for the same sample.
#' The resulting data frame has columns for STATIONID, RUBIN_CODE, TAXON, and the pivoted sample columns.
#' @param data A data frame with columns PLANKTONID, SAMPLEDATE, DEPTH1, DEPTH2, and BIO_VOLUME.
#' @export
pivot_samples <- function(data) {
  if (!requireNamespace("tidyr", quietly = TRUE)) {
    stop("Package tidyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  data <- dplyr::mutate(data, SAMPLEDATE = to_char(SAMPLEDATE, 'dd.mm.yyyy'))

  samples_long <- tidyr::pivot_wider(data,
                                      id_cols = c(STATIONID, RUBIN_CODE, TAXON),
                                      names_from = c(SAMPLEDATE, DEPTHS),
                                      names_glue = "{SAMPLEDATE} ({DEPTHS})",
                                      values_from = BIO_VOLUME)
  return(samples_long)
}
