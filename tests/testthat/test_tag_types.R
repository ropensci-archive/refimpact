library(refimpact)
context("Testing get_tag_types")

test_that("get_tag_types() returns a tibble", {
  # skip_on_cran()
  expect_equal(dim(get_tag_types()),c(13,2))
})
