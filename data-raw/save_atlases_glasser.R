library(here)
library(gifti)
library(data.table)
library(dplyr)
library(tidyr)
library(curl)
library(mfutils)

spaces <- c("fsaverage", "fsaverage5", "fsaverage6", "fsLR")

## read key (from github)

# if (file.exists(here("data-raw", "mmp.csv"))) {
#   key <- fread(here("data-raw", "mmp.csv"))
# } else {
#   key <- fread("https://raw.githubusercontent.com/mcfreund/stroop-rsa/master/out/atlases/mmp.csv")
#   fwrite(key, here("data-raw", "mmp.csv"))
# }
keyfile <- "CortexSubcortex_ColeAnticevic_NetPartition_wSubcorGSR_parcels_LR_LabelKey.txt"
if (file.exists(here("data-raw", "glasser2016", keyfile))) {
  nets <- fread(here("data-raw", "glasser2016", keyfile))
} else {
  nets <- fread(paste0("https://raw.githubusercontent.com/ColeLab/ColeAnticevicNetPartition/master/", keyfile))
  fwrite(nets, here("data-raw", "glasser2016", keyfile))
}

nets <- nets %>%
  select(id = GLASSERLABELNAME, idx = INDEX, hemi = HEMISPHERE, network = NETWORK) %>%
  filter(id != "") %>%
  mutate(
    hemi = paste0(hemi, "H"),
    id = gsub("_ROI", "", id)
    )


## MD assignments (Assem et al)

md <- list(
  core = c("p9-46v", "a9-46v", "i6-8", "AVI", "8C", "IFJp", "IP2", "IP1", "PFm", "8BM", "SCEF"),
  penumbra = c(
    "p10p", "a10p", "11l", "a47r", "p47r", "FOP5", "6r", "s6-8", "a32pr", "d32", "TE1m", "TE1p", "AIP", "LIPd", "MIP",
    "PGs", "POS2"
  )
)
nets$md <- "none"
nets$md[nets$id %in% mikeutils::combo_paste(c("R", "L"), "_", md$core)] <- "core"
nets$md[nets$id %in% mikeutils::combo_paste(c("R", "L"), "_", md$penumbra)] <- "penumbra"

fwrite(nets, here("data-raw", "glasser2016", "glasser2016.txt"))
k <- fread(here("data-raw", "glasser2016", "glasser2016.txt"))

## create atlas objects

for (space_i in seq_along(spaces)) {

  if (spaces[space_i] == "fsLR") {
    fnames <- c(
      here("data-raw", "glasser2016", "Q1-Q6_RelatedParcellation210.L.CorticalAreas_dil_Colors.32k_fs_LR.label.gii"),
      here("data-raw", "glasser2016", "Q1-Q6_RelatedParcellation210.R.CorticalAreas_dil_Colors.32k_fs_LR.label.gii")
    )
  } else {
    fnames <- c(
      here("data-raw", "glasser2016", paste0("lh.HCP-MMP1_", spaces[space_i], ".gii")),
      here("data-raw", "glasser2016", paste0("lh.HCP-MMP1_", spaces[space_i], ".gii"))
    )
  }

  ## create data

  g <- lapply(fnames, read_gifti)
  L <- mfutils::extract_data(g[[1]])
  R <- mfutils::extract_data(g[[2]]) + 180
  R[R == 180] <- 0  ## reset zero to zero!

  stopifnot(length(unique(L[L > 0])) == 180)  ## check if appropriate num parcels
  stopifnot(length(unique(R[R > 0])) == 180)
  stopifnot(all(range(unique(L)) == c(0, 180)))  ## check if appropriate range
  stopifnot(all(range(unique(R)) == c(0, 360)))
  stopifnot(all(range(unique(R[R > 0])) == c(181, 360)))

  d <- rbind(L, R)


  ## create atlas object

  name_space <- paste0("glasser2016", "_", spaces[space_i])

  atlas <- list(
    data = d,
    key = k,
    name = "glasser2016",
    space = spaces[space_i]
  )

  atlas <- mfutils::new_atlas(atlas)
  atlas <- mfutils::validate_atlas(atlas)

  assign(name_space, atlas)
  save(
    list = name_space,
    file = here("data", paste0(name_space, ".RData")),
    compress = "bzip2",
    version = 2
  )

}
