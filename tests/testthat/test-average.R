test_that("average works", {
  M <- matrix(rnorm(40), ncol = 4)
  g <- rep(c("a", "b"), each = 2)
  M_bar <- cbind(a = rowMeans(M[, 1:2]), b = rowMeans(M[, 3:4]))
  expect_equal(M_bar, average(M, g))
})

test_that("average checks inputs", {
  M <- matrix(rnorm(40), ncol = 4)
  expect_error(average(as.data.frame(M), g))
  expect_error(average(M, letters[1:nrow(M)]))
})
