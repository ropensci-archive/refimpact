#' List Tag Types
#'
#' DEPRECATED - USE ref_get. This function uses the \code{ListTagTypes} method
#' from the database API and returns a list of Tag Types and associated
#' metadata.
#'
#' @return Returns a data_frame (from the \code{tibble} package).
#'
#' @examples
#' \dontrun{
#' get_tag_types()
#' }
#'
#' @export
get_tag_types <- function() {
  .Deprecated("ref_get")

  ##### Call the API #####
  query_url <- "http://impact.ref.ac.uk/casestudiesapi/REFAPI.svc/ListTagTypes"
  tmp <- tibble::as_data_frame(jsonlite::fromJSON(query_url))

  return(tmp)

}
