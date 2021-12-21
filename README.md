
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mfutils

<!-- badges: start -->
<!-- badges: end -->

The mfutils package is a collection of R functions that I frequently use
for data analysis. Most of these functions I have created myself,
however some I have found on the interwebs (e.g., stack overflow), in
which case I have also included the relevant attribution/url in the
documentation.

These functions can be sorted into different categories:

-   **general** utilities for constructing and manipulating base R
    objects, such as character vectors and lists
-   common **matrix** operations
-   **plotting** (mostly ggplot2 enhancements)
-   tools for implementing **representational similarity analysis
    (RSA)**, including spatial prewhitening and various distance
    measures
-   convenience functions for working with **gifti** objects from the
    `gifti` package (for surface fMRI data)

Although these categories are pretty different, I currently prefer to
have all of these functions within a single package (rather than a
separate package, e.g., for RSA), as there doesn’t seem to be any
benefit to splitting them up at this point.

## Installation

If for whatever reason you would like to install this package, you can
do so with:

``` r
# install.packages("devtools")
devtools::install_github("mcfreund/mfutils")
```
