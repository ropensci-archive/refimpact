library(refimpact)
context("Testing get_institutions")

skip_on_cran()

test_that("get_institutions() returns a tibble", {
  expect_equal(dim(get_institutions()),c(155,5))
})
