#' List Institutions
#'
#' This function uses the \code{ListInstitutions} method from the database API
#' and returns a list of institutions and associated metadata, including the
#' UKPRN.
#'
#' @return Returns a data_frame (from the \code{tibble} package).
#'
#' @examples
#' \dontrun{
#' get_institutions()
#' }
#'
#' @export
get_institutions <- function() {

  ##### Call the API #####
  query_url <- "http://impact.ref.ac.uk/casestudiesapi/REFAPI.svc/ListInstitutions"
  tmp <- tibble::as_data_frame(jsonlite::fromJSON(query_url))

  return(tmp)

}
