#' Paste all combinations of elements of a set of character vectors.
#'
#' A wrapper for apply(expand.grid())
#'
#' @param a (character) vector 1, left-hand side of output
#' @param b (character) vector 2, right-hand side of output
#' @param ... optional, additional arguments to expand.grid  (e.g., character vectors to combine)
#' @param sep (character) separates the results
#'
#' @return A character vector.
#' @export
#' @keywords strings
#'
#' @examples
#' combo_paste(letters[1:2], letters[3:4], sep = "_")
#' combo_paste(letters[1:2], letters[3:4], LETTERS[24:26], sep = "_")  ## accommodates >2 vectors
combo_paste <- function(a, b, ..., sep = "") {
  stopifnot((is.character(a) || is.numeric(a) || is.factor(a)) && (is.character(b) || is.numeric(b) || is.factor(b)))
  stopifnot(is.null(dim(a)) && is.null(dim(b)))
  apply(expand.grid(a, b, ..., stringsAsFactors = FALSE), 1, paste0, collapse = sep)
}
