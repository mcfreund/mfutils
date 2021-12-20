test_that("centering works", {
  x <- matrix(rnorm(10), ncol = 2)
  xs <- scale(x, scale = FALSE)
  attr(xs, "scaled:center") <- NULL
  expect_equal(center(x), xs)
})

test_that("center checks inputs", {
  expect_error(center(array(1:8, c(3, 3, 2))))
})
