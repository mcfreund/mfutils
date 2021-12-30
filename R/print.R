#' Print method for "atlas" class
#'
#' @param x An object of class "atlas"
#' @param ... Other arguments passed to or from other methods
#'
#' @export
print.atlas <- function(x, ...) {
  stopifnot(is_atlas(x))
  cat(x$name, "in", paste0(x$space, ":"), "\n")
  print(utils::head(x$key), ...)
}
