test_that("indicator works (vs model.matrix)", {
  x <- rep(LETTERS, each = 5)
  M <- model.matrix(~ x + 0)
  attr(M, "assign") <- NULL
  attr(M, "contrasts") <- NULL
  colnames(M) <- gsub("x", "", colnames(M))
  rownames(M) <- NULL
  expect_equal(indicator(x), M)
})

test_that("indicator works, with sort (vs model.matrix)", {
  x <- c("c", "c", "a", "b", "b", "c", "a")
  M <- model.matrix(~ x + 0)
  attr(M, "assign") <- NULL
  attr(M, "contrasts") <- NULL
  colnames(M) <- gsub("x", "", colnames(M))
  rownames(M) <- NULL
  expect_equal(indicator(x), M)
})

test_that("indicator checks inputs", {
  x <- as.factor(rep(LETTERS, each = 5))
  expect_error(indicator(x))
})
