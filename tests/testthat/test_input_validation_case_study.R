library(refimpact)
context("Testing get_case_studies - Input Validation")

test_that("When get_case_studies() is called without arguments, an error is returned", {
  expect_error(check_inputs_get_case_studies())
})

test_that("When ID is provided with any other argument, a warning is shown", {
  expect_warning(check_inputs_get_case_studies(ID=56, UKPRN=10007807),
                 "When the ID argument is used, all other arguments will be ignored.")
  expect_warning(check_inputs_get_case_studies(ID=56, UoA=16),
                 "When the ID argument is used, all other arguments will be ignored.")
  expect_warning(check_inputs_get_case_studies(ID=56, tags=5083),
                 "When the ID argument is used, all other arguments will be ignored.")
  expect_warning(check_inputs_get_case_studies(ID=56, phrase=""),
                 "When the ID argument is used, all other arguments will be ignored.")
  expect_silent( check_inputs_get_case_studies(ID=56))
})

test_that("When ID is not a numeric value, an error is generated", {
  expect_silent(check_inputs_get_case_studies(ID=56))
  expect_silent(check_inputs_get_case_studies(ID=c(56,57)))
  expect_error( check_inputs_get_case_studies(ID="1"))
})

test_that("When UKPRN is not a numeric value of length 1, an error is generated", {
  expect_silent(check_inputs_get_case_studies(UKPRN=10007807))
  expect_error( check_inputs_get_case_studies(UKPRN=c(10007807,10007808)))
  expect_error( check_inputs_get_case_studies(UKPRN="1"))
})

test_that("When UoA is not a numeric value of length 1, an error is generated", {
  expect_silent(check_inputs_get_case_studies(UoA=16))
  expect_error( check_inputs_get_case_studies(UoA=c(16,1)))
  expect_error( check_inputs_get_case_studies(UoA="1"))
})

test_that("When tags is not a numeric value, an error is generated", {
  expect_silent(check_inputs_get_case_studies(tags=5083))
  expect_error( check_inputs_get_case_studies(tags="1"))
})

test_that("When phrase is not a single word, an error is generated", {
  expect_silent(check_inputs_get_case_studies(phrase="hello"))
  expect_error( check_inputs_get_case_studies(phrase="hello world"))
  expect_error( check_inputs_get_case_studies(phrase=1))
})
