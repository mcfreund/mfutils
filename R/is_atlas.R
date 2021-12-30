#' Check if object is of class "atlas"
#'
#' Returns TRUE if yes, FALSE if no.
#'
#' @param x atlas object
#'
#' @return boolean
#' @export
#'
is_atlas <- function(x) {
  inherits(x, "atlas")
}
