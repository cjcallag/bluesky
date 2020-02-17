library(data.table)

wfp_url <- "https://data.humdata.org/dataset/4fdcd4dc-5c2f-43af-a1e4-93c9b6539a27/resource/12d7c8e3-eff9-4db0-93b7-726825c4fe9a/download/wfpvam_foodprices.csv"

init <- fread(wfp_url)[adm0_name == "Mongolia"]



print.data.table <- function(x) print(tibble::as_tibble(x))

dplyr::glimpse(init)

library(dplyr)
adm_1_sf %>% 
  mutate(ADM1_PCODE = as.integer(ADM1_PCODE)) %>% 
  inner_join(init, by = c(ADM1_PCODE = "adm1_id"))
  left_join(init, )
