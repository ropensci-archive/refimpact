# This script contains internal functions used to validate arguments to the
# ListTagValues and SearchCaseStudies API methods.

ListTagValues_validate <- function(api_method, tag_type) {
  if (api_method != "ListTagValues" & !is.null(tag_type)) {
    stop("ref_get: tag_type is only valid for the ListTagValues method.")
  }

  if (api_method == "ListTagValues" & is.null(tag_type)) {
    stop("ref_get:\n",
         "An integer tag_type is required for the ListTagValues method.")
  }

  # if (api_method == "ListTagValues" & !checkmate::test_integerish(tag_type)) {
  #   stop("ref_get: tag_type needs to be an integer.")
  # }

  if (api_method == "ListTagValues") {
    valid_types <- ref_get("ListTagTypes")
    # Check if the tag_type is valid.
    # Casting to char and then to integer to make sure factors are handled.
    if(as.integer(as.character(tag_type)) %in% valid_types$ID) {
      invisible(TRUE)
    } else {
      stop("ref_get \nYour tag_type argument appears invalid. Please check:\n",
     "- tag_type is an integer, or something which can be cast to an integer\n",
     "- tag_type is one of the valid IDs returned from ref_get('ListTagTypes')")
    }
  }

}


SearchCaseStudies_prepare <- function(query) {

  valid_params <- c("ID", "UKPRN", "UoA", "tags", "phrase")

  if ("ID" %in% names(query)) {

    if (sum(valid_params %in% names(query)) > 1) {
      warning("ref_get: When the ID argument is used,",
              "all other arguments will be ignored.")
      query <- list(ID = query$ID)
    }
    if (!checkmate::test_integerish(query$ID)) {
      stop("ref_get:\n",
           "The ID parameter (in the query argument) must be an integer or a",
           " vector of integers.")
    }
    if (length(query$ID) > 1) {
      query$ID <- paste0(query$ID, collapse=",")
    }

  } else {

    if (!checkmate::test_list(query)) {
      stop("ref_get: The query argument must be a list.")
    }

    if (length(query) == 0) {
      stop("ref_get:",
      "The query argument must be a list with at least one query parameter.")
    }

    if (!all(names(query) %in% valid_params) | is.null(names(query))) {
      stop("ref_get: You have used an invalid parameter.\n",
           "Valid parameters include `ID`, `UKPRN`, `UoA`, `tags` and `phrase`")
    }

    if ("UKPRN" %in% names(query)) {
      valid_institutions <- ref_get("ListInstitutions")
      # Check if the UKPRN is valid.
      # Casting to char and then to integer to make sure factors are handled.
      if(!(query$UKPRN %in% valid_institutions$UKPRN)) {
        stop("ref_get \nYour UKPRN argument appears invalid. Please check:\n",
        "- UKPRN is an integer, or something which can be cast to an integer\n",
        "- UKPRN is one of the valid UKPRNs returned from ",
        "ref_get('ListInstitutions')")
      }
    }

    if ("UoA" %in% names(query)) {
      valid_uoa <- ref_get("ListUnitsOfAssessment")
      # Check if the UoA is valid.
      # Casting to char and then to integer to make sure factors are handled.
      if(!(query$UoA %in% valid_uoa$ID)) {
        stop("ref_get \nYour UoA argument appears invalid. Please check:\n",
          "- UoA is an integer, or something which can be cast to an integer\n",
          "- UoA is one of the valid IDs returned from ",
          "ref_get('ListUnitsOfAssessment')")
      }
    }

    if ("tags" %in% names(query)) {
      # Check if the tags are valid.
      # Casting to char and then to integer to make sure factors are handled.
      for (i in seq_along(query$tags)) {
        ref_tags <-
          readRDS(system.file("extdata", "ref_tags.rds", package="refimpact"))
        if(!(query$tags[i] %in% ref_tags$ID)) {
          stop("ref_get \nYour tags argument appears invalid. Please check:\n",
            "- Each tag is an integer, or something which can be cast to one\n",
            "- Each tag is one of the valid IDs in the ref_tags table")
        }
      }

      if (length(query$tags) > 1) {
        query$tags <- paste0(query$tags, collapse=",")
      }
    }

  }

  invisible(query)
}
