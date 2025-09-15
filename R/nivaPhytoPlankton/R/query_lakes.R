#' Queries the t_lakes table
#'
#' @return A lazy table of the T_LAKES table
#'
#' @export
#'
query_lakes <- function() {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  return(dplyr::tbl(con, "T_LAKES") %>% dplyr::select(LAKEID, LAKE, VANNFOREKOMSTID,
                                                       RIVER_BASIN_CODE, LAKE_NUMBER,
                                                       ALTITUDE, MEAN_DEPTH, MAX_DEPTH,
                                                       SURFACE_AREA, LAKE_TYPE, ICTYPEID,
                                                       LAKE_TYPE_CODE, COMMENTS,
                                                       SMWF, COUNTRY))
}
