library(refimpact)
context("Testing ref_get")

test_that("non-valid API methods throw an error", {
  expect_error(ref_get("HelloWorld"))
  expect_error(ref_get("HelloWorld", 5))
  expect_error(ref_get("HelloWorld", query = list(UoA=1)))
})

# Test each API method fully

# Test that the XML error case does the right thing

# Test that it returns a tibble

# Use dput or something to test a few queries to make sure results are staying
# constant over time (no data change)
