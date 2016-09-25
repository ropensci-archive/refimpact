library(refimpact)
context("Testing get_units_of_assessment")

test_that("get_units_of_assessment() returns a tibble", {
  #skip_on_cran()
  expect_equal(dim(get_units_of_assessment()),c(36,3))
})
