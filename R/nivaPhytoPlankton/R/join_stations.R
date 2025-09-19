#' Join t_stations with LAKEID
#' @param qry A lazy table with a LAKEID column
#' @export
join_stations <- function(qry) {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  # Get column names (works for both data frames and lazy tables)
  data_cols <- colnames(qry)

  # Check if SAMPLEDATE column exists (indicates samples table is present)
  if (!"LAKEID" %in% data_cols) {
    stop("You're missing a table with LAKEID to join with t_Stations.",
         call. = FALSE)
  }
  result <- query_stations()

  return (dplyr::left_join(qry, result, by = dplyr::join_by(LAKEID)))
}
