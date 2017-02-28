## ---- eval=FALSE---------------------------------------------------------
#  library(refimpact)
#  library(tibble)
#  data <- get_case_studies(UoA = 3)
#  glimpse(data)
#  View(data) # This only works inside RStudio

## ---- eval=FALSE---------------------------------------------------------
#  data[[1, "Continent"]]

## ---- eval=FALSE---------------------------------------------------------
#  cat(data[[1, "ImpactDetails"]])

## ---- eval=FALSE---------------------------------------------------------
#  units <- get_units_of_assessment()
#  ukprn <- get_institutions()
#  types <- get_tag_types()
#  value <- get_tag_values(3) # Takes a tag type reference as an argument

## ---- eval=FALSE---------------------------------------------------------
#  data <- get_case_studies(UoA = 5, UKPRN = 10007774)

## ---- eval=FALSE---------------------------------------------------------
#  ex1 <- get_case_studies(ID = 941)
#  ex2 <- get_case_studies(ID = c(941, 942, 1014))

