library(refimpact)
context("Testing get_units_of_assessment")

skip_on_cran()

test_that("get_units_of_assessment() returns a tibble", {
  expect_equal(dim(get_units_of_assessment()),c(36,3))
})
