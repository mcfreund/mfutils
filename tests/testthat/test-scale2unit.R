test_that("multiplication works", {
  x <- rnorm(100)
  y <- rnorm(100)
  xs <- x / sqrt(sum(x^2))
  Xs <- cbind(x / sqrt(sum(x^2)), y / sqrt(sum(y^2)))
  expect_equal(scale2unit(x), xs)
  expect_equal(scale2unit(cbind(x, y)), Xs)
})
