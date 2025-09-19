#' Query the taxon groups from the plankton database
#'
#' @param ... Optional filter expressions to apply to the query
#'
#' @return A lazy table of the T_TAXON_GROUPS table with columns RUBIN_CODE, GROUP_NAME and GROUP_SORT
#'
#' @export
query_taxon_groups <- function(...) {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }

  result <- dplyr::select(dplyr::inner_join(dplyr::select(dplyr::tbl(con, dbplyr::in_schema("NIVADATABASE", "TAXONOMY_CODES")), TAXONOMY_CODE_ID, CODE),
                                      dplyr::inner_join(dplyr::select(dplyr::tbl(con, dbplyr::in_schema("NIVADATABASE", "BIO_GROUPS_CODES")), TAXONOMY_CODE_ID, GROUP_ID),
                                      dplyr::filter(dplyr::select(dplyr::tbl(con, dbplyr::in_schema("NIVADATABASE", "BIO_GROUPS")), GROUP_ID, GROUP_TYPE_ID, GROUP_NAME, SORT_CODE),
                                                    GROUP_TYPE_ID == 201),
                                      by = "GROUP_ID"),
                                 by="TAXONOMY_CODE_ID"), RUBIN_CODE = CODE, GROUP_NAME, GROUP_SORT = SORT_CODE)

  if (...length() > 0) {
    result <- dplyr::filter(result, ...)
  }

  return(result)
}
