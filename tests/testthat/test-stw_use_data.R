diamonds <- stw_dataset(ggplot2::diamonds, diamonds_meta)

test_that("named_dots works", {
  a <- 1
  b <- "c"

  named <- list(a = a, b = b)

  expect_identical(name_dots(a, b), named)
})

test_that("validate_list works", {

  withr::local_options(list(usethis.quiet = TRUE))

  diamonds_bad <- diamonds %>% stw_mutate_meta(name = NULL)

  named_good <- list(diamonds = diamonds)
  named_bad <- list(diamonds = diamonds, diamonds_bad = diamonds_bad)
  named_not <- list(a = 1)

  expect_identical(validate_list(named_good), named_good)
  expect_error(validate_list(named_bad), "invalid elements")
  expect_error(validate_list(named_not), "invalid elements")
})

test_that("strip_steward works", {
  expect_identical(strip_steward(diamonds), ggplot2::diamonds)
})



