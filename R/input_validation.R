# This script contains internal functions used to validate arguments to the
# ListTagValues and SearchCaseStudies API methods.

ListTagValues_validate <- function(api_method, tag_type) {
  if (api_method != "ListTagValues" & !is.null(tag_type)) {
    stop("ref_get: tag_type is only valid for the ListTagValues method.")
  }

  if (api_method == "ListTagValues" & is.null(tag_type)) {
    stop("ref_get: An integer tag_type is required for the ListTagValues method.")
  }

  if (api_method == "ListTagValues" & !checkmate::test_integerish(tag_type)) {
    stop("ref_get: tag_type needs to be an integer.")
  }

  invisible(TRUE)
}


SearchCaseStudies_prepare <- function(query) {

  if (!checkmate::test_list(query)) {
    stop("ref_get: The query argument must be a list.")
  }

  if (length(query) == 0) {
    stop("ref_get: The query argument must be a list with at least one query parameter.")
  }

  valid_params <- c("ID", "UKPRN", "UoA", "tags", "phrase")
  if (!all(names(query) %in% valid_params)) {
    stop("ref_get: You have used an invalid parameter. Valid parameters include `ID`, `UKPRN`, `UoA`, `tags` and `phrase`")
  }

  if ("ID" %in% names(query)) {
    if (sum(valid_params %in% names(query)) > 1) {
      warning("ref_get: When the ID argument is used, all other arguments will be ignored.")
      query <- list(ID = query$ID)
    }
    if (!checkmate::test_integerish(query$ID)) {
      stop("ref_get: The ID parameter (in the query argument) must be an integer or a vector of integers.")
    }
    if (length(query$ID) > 1) {
      query$ID <- paste0(query$ID, collapse=",")
    }
  }


  # if (!is.null(UKPRN) & class(UKPRN) != "numeric" | length(UKPRN) > 1) {
  #   stop("UKPRN must be a single numeric value.")
  # }
  #
  # if (!is.null(UoA) & class(UoA) != "numeric" | length(UoA) > 1) {
  #   stop("UoA must be a single numeric value.")
  # }
  #
  # if (!is.null(tags) & class(tags) != "numeric") {
  #   stop("tags must be either a single numeric value, or a vector of numeric values.")
  # }
  #
  # if (!is.null(phrase) & class(phrase) != "character") {
  #   stop("phrase must be a single word.")
  # } else if (!is.null(phrase)) {
  #   if (grepl(" ",phrase)) stop("phrase must be a single word.")
  # }

  invisible(query)
}
