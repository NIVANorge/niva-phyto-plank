#' Query taxon information from the plankton database
#'
#' @return  A lazy table of the T_TAXON_INFORMATION table
#'
#' @export
query_taxons <- function() {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  return(dplyr::select(dplyr::tbl(con, "T_TAXON_INFORMATION"), RUBIN_CODE, TAXON_NAME, TAXON_VOLUME_SINGLECELLS,
                         TAXON_VOLUME_COLONY, CELLS_IN_COLONY, COLONY_STRUCTURE,
                         PERSON, DATE_REGISTRY))
}
