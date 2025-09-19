#' Queries the t_lakes table
#'
#' @param ... Optional filter expressions to apply to the query
#'
#' @return A lazy table of the T_LAKES table
#'
#' @export
#'
query_lakes <- function(...) {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }

  result <- dplyr::select(dplyr::tbl(con, "T_LAKES"), LAKEID, LAKE, VANNFOREKOMSTID,
                                                       RIVER_BASIN_CODE, LAKE_NUMBER,
                                                       ALTITUDE, MEAN_DEPTH, MAX_DEPTH,
                                                       SURFACE_AREA, LAKE_TYPE, ICTYPEID,
                                                       LAKE_TYPE_CODE, COMMENTS,
                                                       SMWF, COUNTRY)

  if (...length() > 0) {
    result <- dplyr::filter(result, ...)
  }

  return(result)
}
