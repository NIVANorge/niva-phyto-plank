#' Query samples from the plankton database
#'
#' @param ... Optional filter expressions to apply to the query
#'
#' @return A lazy table of the T_SAMPLE table
#'
#' @export
query_samples <- function(...) {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }

  result <- dplyr::select(dplyr::tbl(con, "T_SAMPLE"), SAMPLEID,STATIONID,SAMPLEDATE,
                                                        DEPTHS,DEPTH_1,DEPTH_2,PERSON,
                                                        COMMENTS)

  if (...length() > 0) {
    result <- dplyr::filter(result, ...)
  }

  return(result)
}
