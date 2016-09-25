library(refimpact)
context("Testing get_tag_values")

test_that("get_tag_value() returns a tibble", {
  #skip_on_cran()
  expect_equal(dim(get_tag_values(3)),c(313,2))
})

test_that("get_tag_value() generates an error for a string argument", {
  #skip_on_cran()
  expect_error(dim(get_tag_values("hello world")))
})
