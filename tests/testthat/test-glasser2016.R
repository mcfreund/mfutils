test_that("all glasser atlas files are valid atlas objects", {

  spaces <- c("fsaverage", "fsaverage5", "fsaverage6", "fsLR")
  for (space_i in seq_along(spaces)) {
    atlas <- load_atlas("glasser2016", space = spaces[space_i])
    expect_equal(validate_atlas(atlas), atlas)
    rm(atlas)
  }

})

