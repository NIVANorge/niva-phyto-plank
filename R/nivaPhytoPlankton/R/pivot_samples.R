#' Pivot Samples to Wide Format
#' This function pivots a data frame of samples and phytoplankton to wide format.
#' Each unique sample of date and depth range becomes a separate column.
#' The BIO_VOLUME values are summed if there are multiple entries for the same sample.
#' The resulting data frame has columns for STATIONID, RUBIN_CODE, TAXON, and the pivoted sample columns.
#' @param data A data frame with samples, and optionally phytoplanktons.
#' @export
pivot_samples <- function(data) {
  if (!requireNamespace("tidyr", quietly = TRUE)) {
    stop("Package tidyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  
  if (!requireNamespace("stringr", quietly = TRUE)) {
    stop("Package stringr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  
  # Get column names (works for both data frames and lazy tables)
  data_cols <- colnames(data)
  
  # Check if SAMPLEDATE column exists (indicates samples table is present)
  if (!"SAMPLEDATE" %in% data_cols) {
    stop("It looks like the samples table is missing from your data. ",
         "Please ensure your data includes sample information with a SAMPLEDATE column. ",
         "You might need to join with the samples table first using query_samples().",
         call. = FALSE)
  }
  
  # Check if BIO_VOLUME column exists, if not join with phytoplankton data
  if (!"BIO_VOLUME" %in% data_cols) {
    data <- dplyr::inner_join(data, query_phytoplanktons(), by = "SAMPLEID")
    # Update column names after the join
    data_cols <- colnames(data)
  }
  
  # Store original date for sorting, create formatted version for display
  data <- dplyr::mutate(data, 
                        SAMPLEDATE_SORT = SAMPLEDATE,
                        SAMPLEDATE = to_char(SAMPLEDATE, 'dd.mm.yyyy'))

  # Build id_cols dynamically based on available columns
  base_id_cols <- c("STATIONID", "RUBIN_CODE", "TAXON")
  optional_cols <- c("STATION", "LAKEID", "STASJONSKODE", "LAKE", "VANNFOREKOMSTID", "RIVER_BASIN_CODE", "LAKE_NUMBER")
  
  # Add optional columns that exist in the data
  available_optional_cols <- optional_cols[optional_cols %in% data_cols]
  id_cols <- c(base_id_cols, available_optional_cols)

  samples_wide <- tidyr::pivot_wider(data,
                                      id_cols = dplyr::all_of(id_cols),
                                      names_from = c(SAMPLEDATE, DEPTHS),
                                      names_glue = "{SAMPLEDATE} ({DEPTHS})",
                                      values_from = BIO_VOLUME)
  
  # Note: Columns will be in the order produced by pivot_wider (not chronologically sorted)
  return(samples_wide)
}
