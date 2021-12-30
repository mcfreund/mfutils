#' Load atlas
#'
#' https://adv-r.hadley.nz/s3.html
#'
#' @param name character string of atlas name
#' @param space character string of atlas name
#'
#' @return object of type atlas
#' @export
#'
#' @example
#' atlas <- load_atlas(name = "schaefer2018_17_200", space = "fsaverage6")
#' atlas
load_atlas <- function(name, space) {
  get(paste0(name, "_", space))
}

