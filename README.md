
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mfutils

<!-- badges: start -->
<!-- badges: end -->

The mfutils package is a collection of various R functions that I
frequently use. Most of these functions I have created myself, however
some I have found on stackexchange (and included the attribution/url in
the documentation).

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
have these functions all within a single package (e.g., rather than a
separate package for RSA), just to keep things simple.

## Installation

You can install the released version of mfutils from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("mfutils")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("mcfreund/mfutils")
```
