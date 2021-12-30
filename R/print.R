print.atlas <- function(x, ...) {
  stopifnot(is_atlas(x))
  cat(x$name, "in", paste0(x$space, ":"), "\n")
  print(utils::head(x$key), ...)
}
