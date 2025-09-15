#' Query the t_phytoplankton table
#'
#' @return A lazy table of the T_PHYTOPLANKTON table
#'
#' @export
query_phytoplanktons <- function() {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }
  if (!requireNamespace("dplyr", quietly = TRUE)) {
    stop("Package dplyr needed for this function to work. Please install it.",
         call. = FALSE)
  }
  return(dplyr::select(dplyr::tbl(con, "T_PHYTOPLANKTON"), PLANKTONID, SAMPLEID, RUBIN_CODE,
                       TAXON, CONFER, SINGLE_SPECIES, VALUE, FACTOR,
                         TAXON_VOLUME, BIO_VOLUME, COUNTING_DATE,
                         COUNTING_LEVEL, NUMBER_OF_UNITS,
                         SAMPLE_TYPE, PROJECT_TYPE))
}
