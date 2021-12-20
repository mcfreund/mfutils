#' Create indicator matrix from character vector.
#'
#' Rows of an indicator matrix correspond to "observations".
#' Columns correspond to "conditions" (e.g., levels of a factor).
#' Each observation "belongs" to only one condition.
#' This membership is indicated by a 1 in the corresponding column (otherwise 0).
#'
#' @param x character vector of length n
#'
#' @return Indicator matrix. Column names taken from unique(x).
#' @export
#' @keywords computation, matrix
#'
#' @examples
#' x <- rep(letters[1:4], each = 4)
#' M <- indicator(x)
#' nrow(M) == length(x)
#' ncol(M) == length(unique(x))
#' M == stats::model.matrix(~ as.factor(x) + 0)
indicator <- function(x) {
  stopifnot(is.character(x))
  u <- sort(unique(x))
  m <- matrix(0, nrow = length(x), ncol = length(u), dimnames = list(NULL, u))
  idx <- as.numeric(factor(x))
  m[cbind(seq_along(x), idx)] <- 1
  m
}
