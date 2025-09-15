#' Join taxon groups from Nivadatabase with a Phytoplankton query
#' @param qryPlankton A lazy table with a RUBIN_CODE column
#' @export
join_taxon_groups <- function(qryPlankton) {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  qry_taxon_codes <- dplyr::select(dplyr::inner_join(dplyr::select(dplyr::tbl(con, dbplyr::in_schema("NIVADATABASE", "TAXONOMY_CODES")), TAXONOMY_CODE_ID, CODE),
                                      dplyr::inner_join(dplyr::select(dplyr::tbl(con, dbplyr::in_schema("NIVADATABASE", "BIO_GROUPS_CODES")), TAXONOMY_CODE_ID, GROUP_ID),
                                      dplyr::filter(dplyr::select(dplyr::tbl(con, dbplyr::in_schema("NIVADATABASE", "BIO_GROUPS")), GROUP_ID, GROUP_TYPE_ID, GROUP_NAME, SORT_CODE),
                                                    GROUP_TYPE_ID == 201),
                                      by = "GROUP_ID"),
                                 by="TAXONOMY_CODE_ID"), CODE, GROUP_NAME, SORT_CODE)

  return (dplyr::left_join(qryPlankton, qry_taxon_codes, by = dplyr::join_by(RUBIN_CODE == CODE)))
}
