library("tibble")

dict_test <- diamonds_meta$dict

dict_combined <- add_row(dict_test, name = "foo", description = "bar")

dict_changed <- dict_test
dict_changed$description[2] <- "foo"
dict_changed$description[4] <- "bar"

test_that("internal dictionary-mutation works", {

  dict <- tribble(
    ~name, ~description,
    "foo", "bar",
    "foo2", "bar2"
  )

  dict_change <- tribble(
    ~name, ~description,
    "foo", "baz",
    "foo2", "bar2"
  )

  dict_add <- tribble(
    ~name, ~description,
    "foo", "bar",
    "foo2", "bar2",
    "new", "baz"
  )

  expect_identical(
    dict_describe(dict, name ="foo", description = "baz"),
    dict_change
  )

  expect_identical(
    dict_describe(dict, name ="new", description = "baz"),
    dict_add
  )

})

test_that("stw_dict method works", {

  expect_identical(
    stw_mutate_dict(dict_test, foo = "bar"),
    dict_combined
  )

  expect_identical(
    stw_mutate_dict(dict_test, carat = "foo", color = "bar"),
    dict_changed
  )

})


test_that("stw_meta method works", {

  diamonds_meta_combined <- diamonds_meta
  diamonds_meta_combined$dict <- dict_combined

  diamonds_meta_changed <- diamonds_meta
  diamonds_meta_changed$dict <- dict_changed

  expect_identical(
    stw_mutate_dict(diamonds_meta, foo = "bar"),
    diamonds_meta_combined
  )

  expect_identical(
    stw_mutate_dict(diamonds_meta, carat = "foo", color = "bar"),
    diamonds_meta_changed
  )

})
