test_that("enlist works", {
  expect_equal(enlist(c("a", "b")), list(a = NULL, b = NULL))
})
test_that("enlist checks inputs", {
  expect_error(enlist(as.factor(c("a", "b"))))
  expect_error(enlist(list()))
})
