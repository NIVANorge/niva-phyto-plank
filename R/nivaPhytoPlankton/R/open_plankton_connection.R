#' Opens a new connection to the Oracle database setting up PHYTOPLANKTON schema
#'
#' @return A DBI connection object
#'
#' @details This function will ask for username, password from the user.
#' It will look for an installed driver using NIVA common install routines.
#' It will connect to Nivadatabase production host, but this could be changed by setting
#' environment variable ORACLE_DNS.
#' @export
#'
open_plankton_connection <- function() {
  if (!requireNamespace("DBI", quietly = TRUE)) {
    stop("Package DBI needed for this function to work. Please install it.",
         call. = FALSE)
  }
  if (!requireNamespace("odbc", quietly = TRUE)) {
    stop("Package odbc needed for this function to work. Please install it.",
         call. = FALSE)
  }

  # Ask for username and password
  user <- readline(prompt = "Enter Oracle username: ")
  password <- getPass::getPass("Enter Oracle password: ")

  # Get DNS from environment variable or use default
  dns <- Sys.getenv("ORACLE_DNS")
  if (dbs == "") {
    dbs <- "NIVABASE"
  }

  # Create connection
  con <- DBI::dbConnect(odbc::odbc(),
                        DNS = dns,
                        UID = user,
                        PWD = password,
                        encoding = "UTF-8")
  DBI::dbExecute(con, "ALTER SESSION SET CURRENT_SCHEMA=PHYTOPLANKTON")
  return(con)
}
