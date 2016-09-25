library(refimpact)
context("Testing get_tag_values")

skip_on_cran()

test_that("get_tag_value() returns a tibble", {
  expect_equal(dim(get_tag_values(3)),c(313,2))
})

test_that("get_tag_value() generates an error for a string argument", {
  expect_error(dim(get_tag_values("hello world")))
})
