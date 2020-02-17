# adm_0_url <- "https://data.humdata.org/dataset/a9b0a8a6-cb14-448e-b35c-aa5eb51b0557/resource/f881ee41-bedb-4a76-bdff-453628cb0c61/download/mng_admbnda_adm0_nso_v3.zip"
# adm_1_url <- "https://data.humdata.org/dataset/a9b0a8a6-cb14-448e-b35c-aa5eb51b0557/resource/dd683294-a2c6-4595-88df-a648be4aac7c/download/mng_admbnda_adm1_nso_v3.zip"
# adm_2_url <- "https://data.humdata.org/dataset/a9b0a8a6-cb14-448e-b35c-aa5eb51b0557/resource/7cbbf15e-520d-472e-bfb7-c2b5d4468f80/download/mng_admbnda_adm2_nso_v3.zip"
# adm_region_url <- "https://data.humdata.org/dataset/a9b0a8a6-cb14-448e-b35c-aa5eb51b0557/resource/c8dd1935-ff40-4a28-ada6-394361790490/download/mng_admbnda_region_nso_v3.zip"

# aimag_url <- "http://marine.rutgers.edu/~cfree/files/gis-files/aimag_boundaries.zip"
aimag_url <- "http://marine.rutgers.edu/~cfree/files/gis-files/aimagbnd.rar"
special_protected_areas_url <- "http://marine.rutgers.edu/~cfree/files/gis-files/spa.rar"
# soum_url <- "http://marine.rutgers.edu/~cfree/files/gis-files/soum_boundaries.zip"

sf_from_shp <- function(url) {
  file_ext <- stringr::str_extract(url, "(zip|rar)$")
  
  if (file_ext == "zip") {
    temp_file <- tempfile(fileext = ".zip")
  } else if (file_ext == "rar") {
    temp_file <- tempfile(fileext = ".rar")
  } else {
    stop("unknown file extension.")
  }
  
  download.file(url, destfile = temp_file)
  temp_dir <- tempdir(check = TRUE)
  target_dir <- paste0(temp_dir, "/", basename(url))
  dir.create(target_dir, recursive = TRUE)
  on.exit(unlink(target_dir, force = TRUE, recursive = TRUE))
  
  if (file_ext == "zip") {
    unzip(zipfile = x, exdir = exdir)
  } else {
    cmd <- sprintf("unrar e %s %s", temp_file, target_dir)
    system(command = cmd)
  }
  
  shp <- dir(target_dir, pattern = "\\.shp$", full.names = TRUE)

  sf::read_sf(shp)
}

aimag_sf <- sf_from_shp(aimag_url)
special_protected_areas_sf <- sf_from_shp(special_protected_areas_url)
# soum_sf <- sf_from_shp(soum_url)

# adm_0_sf <- sf_from_shp(adm_0_url)
adm_1_sf <- sf_from_shp(adm_1_url)
# adm_2_sf <- sf_from_shp(adm_2_url)
# adm_region_sf <- sf_from_shp(adm_region_url)
# 
# usethis::use_data(adm_0_sf, overwrite = TRUE)
# usethis::use_data(adm_1_sf, overwrite = TRUE)
# usethis::use_data(adm_2_sf, overwrite = TRUE)
# usethis::use_data(adm_region_sf, overwrite = TRUE)
