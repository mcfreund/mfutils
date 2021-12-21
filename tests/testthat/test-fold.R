test_that("fold works", {
  X <- matrix(1:9, ncol = 3)
  target <- rbind(c(1, 3, 5), c(3, 5, 7), c(5, 7, 9))
  expect_equal(fold(X), target)
})


test_that("fold works, larger matrix", {
  X <- matrix(rnorm(100), ncol = 10)
  row3 <- (X[3, ] + X[, 3])/2
  expect_equal(fold(X)[3, ], row3)
})
