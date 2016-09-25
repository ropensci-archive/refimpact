library(refimpact)
context("Testing get_case_studies")

test_that("Function returns sensible data frames for sensible queries", {
  #skip_on_cran()
  expect_equal(dim(get_case_studies(ID=56)),c(1,19))
  expect_equal(dim(get_case_studies(ID=c(56,57))),c(2,19))
  expect_equal(dim(get_case_studies(UKPRN=10007807)),c(63,19))
  expect_equal(dim(get_case_studies(UoA=16)),c(140,19))
})
