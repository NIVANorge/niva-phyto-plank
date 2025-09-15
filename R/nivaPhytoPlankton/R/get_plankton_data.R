#' Gets data from the plankton database
#'
#' Given a query, gets data from Oracle database.
#'
#' @param sql SQL string
#'
#' @return Data frame
#' @details This function will try to use the variable con as a connection to the database.
#' If con does not exist, it will try to create a new connection using the function open_connection.
#' @export
get_plankton_data <- function(sql) {
  if (!exists("con")) {
    con <- open_plankton_connection()
  }

  df <- DBI::dbGetQuery(con, sql)
  return(df)
}
