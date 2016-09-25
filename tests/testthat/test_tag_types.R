library(refimpact)
context("Testing get_tag_types")

skip_on_cran()

test_that("get_tag_types() returns a tibble", {
  expect_equal(dim(get_tag_types()),c(13,2))
})
