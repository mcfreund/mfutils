#' Find the mode of a vector.
#'
#' From Ken Williams' answer: https://stackoverflow.com/questions/2547402/is-there-a-built-in-function-for-finding-the-mode
#' @param x a vector
#' @param all.modes boolean that indicates whether multiple modes should be returned if they exist

#' @export
Mode <- function(x, all.modes = TRUE) {

  ux <- unique(x)

  if (!all.modes) {
    ## returns first mode in case of multiple
    ux[which.max(tabulate(match(x, ux)))]
  } else {
    ## returns all modes in case of multiple
    tab <- tabulate(match(x, ux))
    ux[tab == max(tab)]
  }
}
