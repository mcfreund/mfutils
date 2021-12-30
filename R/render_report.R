#' Dynamically render rmarkdown report with parameters.
#'
#' See here for more information: https://bookdown.org/yihui/rmarkdown/params-knit.html
#'
#' @param name (character) .rdm file name
#' @param src_dir (character) directory within \code{base_dir} that contains \code{name}
#' @param params optional list of parameters to pass to \code{rmarkdown::render}
#' @param ... additional optional parameters for \code{rmarkdown::render}
#' @param envir environment in which to run \code{rmarkdown::render} (default: new.env())
#' @param base_dir location of \code{src_dir} on machiene, defaults to \code{here::here("src")}
#'
#' @export
render_report <- function(
  name, src_dir, params = NULL, ..., envir = new.env(), base_dir = here::here("src")
) {

  if (is.null(params)) {
    output_file <- paste0(name, ".html")
  } else {
    output_file <- paste0(name, "__", paste0(paste0(names(params), "-", params), collapse = "__"), ".html")
  }

  rmarkdown::render(
    file.path(base_dir, src_dir, paste0(name, ".rmd")),
    params = params,
    output_file = output_file,
    envir = envir,
    ...
  )
}
