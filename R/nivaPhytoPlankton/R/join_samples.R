#' Join t_samples with STATIONID
#' @param qry A lazy table with a STATIONID column
#' @export
join_samples <- function(qry) {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  # Get column names (works for both data frames and lazy tables)
  data_cols <- colnames(qry)

  # Check if SAMPLEID column exists
  if (!"STATIONID" %in% data_cols) {
    stop("You're missing a data frame with STATIONID to join with t_Samples.",
         call. = FALSE)
  }
  result <- query_samples()

  return (dplyr::left_join(qry, result, by = dplyr::join_by(STATIONID)))
}
