#' Rename elements of a given dimension within an array
#'
#' A convenience function for working with matrices or arrays.
#'
#' @param m matrix or array
#' @param new_names character
#' @param DIM numeric index or name of dimension (if dimensions are named) whose elements will be renamed
#'
#' @keywords general, strings
#'
#' @return m but with new names
#' @export
#' @examples
#' m <- array(1:8, dim = c(3, 3, 2))
#' rename_dim(m, c("newname1", "newname2"), 3)
rename_dim <- function(m, new_names, DIM = 2) {
  if (!is.array(m)) stop("x must be matrix or array")
  dimnames(m)[[DIM]] <- new_names
  m
}
