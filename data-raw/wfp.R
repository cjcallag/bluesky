library(data.table)

wfp_url <- "https://data.humdata.org/dataset/4fdcd4dc-5c2f-43af-a1e4-93c9b6539a27/resource/12d7c8e3-eff9-4db0-93b7-726825c4fe9a/download/wfpvam_foodprices.csv"

init <- fread(wfp_url)

print.data.table <- function(x) print(tibble::as_tibble(x))

init[adm0_name == "Mongolia"] %>% dplyr::glimpse()

mongolia <- sf::st_as_sf(
  raster::getData(country = "Mongolia", level = 1)
)


rnaturalearthdata::

mongolia %>% 
  dplyr::inner_join(init, by = c("GID"))

