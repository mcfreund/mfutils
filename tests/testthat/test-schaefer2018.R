test_that("all schaefer atlas files are valid atlas objects", {

  nparcs <- seq(100, 1000, 100)
  nnetws <- c(7, 17)
  spaces <- c("fsaverage", "fsaverage5", "fsaverage6")
  for (nparc_i in seq_along(nparcs)) {
    for (nnetw_i in seq_along(nnetws)) {
      for (space_i in seq_along(spaces)) {
        atlas <- load_atlas(paste0("schaefer2018_", nnetws[nnetw_i], "_", nparcs[nparc_i]), space = spaces[space_i])
        expect_equal(validate_atlas(atlas), atlas)
        rm(atlas)
      }
    }
  }


})

