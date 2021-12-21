test_that("squareform works for lt<->matrix, both correlation and distance", {

  X <- matrix(rnorm(25), ncol = 5)
  R <- cor(X)
  r <- R[lower.tri(R)]
  D <- as.matrix(dist(t(X)))
  dimnames(D) <- NULL
  d <- D[lower.tri(D)]

  expect_equal(squareform(R, corr = TRUE, lt = TRUE), r)
  expect_equal(squareform(r, corr = TRUE, lt = TRUE), R)

  expect_equal(squareform(D, lt = TRUE), d)
  expect_equal(squareform(d, lt = TRUE), D)

})
