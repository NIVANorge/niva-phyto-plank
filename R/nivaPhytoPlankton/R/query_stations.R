#' Query the stations from the plankton database
#'
#' @param ... Optional filter expressions to apply to the query
#'
#' @return A lazy table of the T_STATIONS table
#'
#' @export
query_stations <- function(...) {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }

  result <- dplyr::select(dplyr::tbl(con, "T_STATIONS"), STATIONID, STATION, LAKEID, STASJONSKODE,
                         ST_CODE, ST_CODE_FAG, LATITUDE, LONGITUDE,
                         COMMENTS)

  if (...length() > 0) {
    result <- dplyr::filter(result, ...)
  }

  return(result)
}
