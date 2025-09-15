#' Opens a new connection to the Oracle database
#'
#' @return A DBI connection object
#'
#' @details This function will ask for username, password from the user.
#' It will look for an installed driver, but otherwise try to get the
#' driver from the environment variable ORACLE_DRIVER_PATH.
#' If the environment variable is not set, it will try to use a default path
#' according to Jupyterhub usage.
#' @export
#'
open_connection <- function() {
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

  # Try to find a driver
  drivers <- odbc::odbcListDrivers()
  driver_name <- "Oracle in OraClient19Home1"
  if (!(driver_name %in% drivers$name)) {
    driver_path <- Sys.getenv("ORACLE_DRIVER_PATH")
    if (driver_path == "") {
      # Try a default path for Jupyterhub usage
      driver_path <- "/usr/lib/oracle/23/client64/lib/libsqora.so.23.1"
    }
    if (!file.exists(driver_path)) {
      stop(paste("Oracle driver not found. Please set the environment variable ORACLE_DRIVER_PATH to the path of the driver."), call. = FALSE)
    }
    driver_name <- driver_path
  }

  # Create connection
  con <- DBI::dbConnect(odbc::odbc(),
                        Driver = driver_name,
                        DBQ = "dbora-niva-prod01.niva.corp:1553/NIVABTST",
                        UID = user,
                        PWD = password,
                        encoding = "UTF-8")
  DBI::dbExecute(con, "ALTER SESSION SET CURRENT_SCHEMA=PHYTOPLANKTON")
  return(con)
}
