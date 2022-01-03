#' Generates a contrast matrix for forming cross-validated euclidean distance matrix.
#'
#' Primarily for internal use.
#'
#' @param n The number of conditions among which to estimate pattern contrasts. (Numeric vector of length 1.)
#' @param condition_names An optional character vector that gives the name of each condition.
#' This vector specifies the colnames of the contrast matrix.
#'
#' @return A numeric matrix (n^2 by n).
#' @export
#'
contrast_matrix <- function(n, condition_names) {

  stopifnot(is.numeric(n) && length(n) == 1)
  if (!missing(condition_names)) stopifnot(length(condition_names) == length(n))
  if (n < 2) stop("you need more than 1 condition you dummy")

  M <- matrix(0, nrow = n^2, ncol = n)

  if (missing(condition_names)) {
    dimnames(M) <- list(contrast = NULL, condition = NULL)
  } else {
    dimnames(M) <- list(
      contrast = paste0(rep(condition_names, each = n), "_", rep(condition_names, n)),
      condition = condition_names
    )
  }

  for (condition_i in seq_len(n)) {
    row_beg <- (condition_i - 1) * n + 1
    row_end <- (condition_i - 1) * n + n
    M_i <- M[row_beg:row_end, ]  ## square matrix; the contrasts that define a column of the similarity matrix

    M_i[, condition_i] <- 1  ## the condition to which all others are contrasted
    diag(M_i) <- diag(M_i) - 1  ## all others

    M[row_beg:row_end, ] <- M_i
  }

  M

}
