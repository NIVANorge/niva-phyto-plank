#' Join t_Phytoplankton with SAMPLEID
#' @param qry A lazy table with a SAMPLEID column
#' @export
join_phytoplanktons <- function(qry) {
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
  if (!"SAMPLEID" %in% data_cols) {
    stop("You're missing a data frame with SAMPLEID to join with t_Phytoplankton.",
         call. = FALSE)
  }
  result <- query_phytoplanktons()

  return (dplyr::left_join(qry, result, by = dplyr::join_by(SAMPLEID)))
}
