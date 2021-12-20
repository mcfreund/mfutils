test_that(
  "handles inputs", {
    expect_error(combo_paste(diag(10), LETTERS[1:2]))
    expect_error(combo_paste(LETTERS[1:2], diag(10)))
  }
)

test_that(
  "combines character vectors", {
    expect_equal(combo_paste(letters[1:2], LETTERS[1:2]), c("aA", "bA", "aB", "bB"))
    expect_equal(combo_paste(letters[1:2], LETTERS[1:2], letters[1:2]), c("aAa", "bAa", "aBa", "bBa", "aAb", "bAb", "aBb", "bBb"))
  }
)

test_that(
  "handles factor and numeric variables", {
    expect_equal(combo_paste(as.factor(letters[1:2]), LETTERS[1:2]), c("aA", "bA", "aB", "bB"))
    expect_equal(combo_paste(as.factor(letters[1:2]), 1:2), c("a1", "b1", "a2", "b2"))
  }
)
