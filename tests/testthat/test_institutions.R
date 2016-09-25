library(refimpact)
context("Testing get_institutions")

test_that("get_institutions() returns a tibble", {
  #skip_on_cran()
  expect_equal(dim(get_institutions()),c(155,5))
})
