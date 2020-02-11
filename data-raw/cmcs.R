# https://cmcs.mram.gov.mn/cmcs#c=License
curl_cmd <- "curl 'https://cmcs.mram.gov.mn/CMCS//License/GridData' -H 'authority: cmcs.mram.gov.mn' -H 'accept: application/json, text/javascript, */*; q=0.01' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'origin: https://cmcs.mram.gov.mn' -H 'sec-fetch-site: same-origin' -H 'sec-fetch-mode: cors' -H 'referer: https://cmcs.mram.gov.mn/cmcs' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __RequestVerificationToken_L0NNQ1M1=8Ch83z9AfrKm4Dvmr3Z6mVufh-bi7W_eAn_pL82bfzlqBMJv37zV5XQtnQINStjflP-e0WE38mYy9xtZRxo8UV1I1Oc1' --data '_search=false&nd=1581431326683&rows=2782&page=1&sidx=ObjectId&sord=desc' --compressed --insecure"

res <- system(command = curl_cmd, intern = TRUE)

parsed <- jsonlite::parse_json(res)

col_names <- c("id", "code", "name", "type", "status", "holder_applicant",
               "area_hectares", "button")

out <- data.table::rbindlist(
  lapply(parsed$rows, function(.x) {
    out <- .x[["cell"]]
    names(out) <- col_names
    out
  })
)

out[, area_hectares := as.double(area_hectares)
    ][, button := NULL
      ]

cmcs_licenses_df <- tibble::as_tibble(out)

usethis::use_data(cmcs_licenses_df, overwrite = TRUE)


###
curl_cmds <- c(
  reserved = "curl 'https://cmcs.mram.gov.mn/CMCS//SpecialArea/GridData' -H 'authority: cmcs.mram.gov.mn' -H 'accept: application/json, text/javascript, */*; q=0.01' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'origin: https://cmcs.mram.gov.mn' -H 'sec-fetch-site: same-origin' -H 'sec-fetch-mode: cors' -H 'referer: https://cmcs.mram.gov.mn/cmcs' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __RequestVerificationToken_L0NNQ1M1=8Ch83z9AfrKm4Dvmr3Z6mVufh-bi7W_eAn_pL82bfzlqBMJv37zV5XQtnQINStjflP-e0WE38mYy9xtZRxo8UV1I1Oc1' --data 'indexType=3&_search=false&nd=1581438110406&rows=1000&page=1&sidx=Id&sord=desc' --compressed --insecure",
  strategic_deposit = "curl 'https://cmcs.mram.gov.mn/CMCS//SpecialArea/GridData' -H 'authority: cmcs.mram.gov.mn' -H 'accept: application/json, text/javascript, */*; q=0.01' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'origin: https://cmcs.mram.gov.mn' -H 'sec-fetch-site: same-origin' -H 'sec-fetch-mode: cors' -H 'referer: https://cmcs.mram.gov.mn/cmcs' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __RequestVerificationToken_L0NNQ1M1=8Ch83z9AfrKm4Dvmr3Z6mVufh-bi7W_eAn_pL82bfzlqBMJv37zV5XQtnQINStjflP-e0WE38mYy9xtZRxo8UV1I1Oc1' --data 'indexType=6&_search=false&nd=1581438148159&rows=1000&page=1&sidx=Id&sord=desc' --compressed --insecure",
  available_for_new_exploration_licenses = "curl 'https://cmcs.mram.gov.mn/CMCS//SpecialArea/GridData' -H 'authority: cmcs.mram.gov.mn' -H 'accept: application/json, text/javascript, */*; q=0.01' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'origin: https://cmcs.mram.gov.mn' -H 'sec-fetch-site: same-origin' -H 'sec-fetch-mode: cors' -H 'referer: https://cmcs.mram.gov.mn/cmcs' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __RequestVerificationToken_L0NNQ1M1=8Ch83z9AfrKm4Dvmr3Z6mVufh-bi7W_eAn_pL82bfzlqBMJv37zV5XQtnQINStjflP-e0WE38mYy9xtZRxo8UV1I1Oc1' --data 'indexType=8&_search=false&nd=1581438178748&rows=1000&page=1&sidx=Id&sord=desc' --compressed --insecure",
  artisinal_or_small_scale_mining = "curl 'https://cmcs.mram.gov.mn/CMCS//SpecialArea/GridData' -H 'authority: cmcs.mram.gov.mn' -H 'accept: application/json, text/javascript, */*; q=0.01' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'origin: https://cmcs.mram.gov.mn' -H 'sec-fetch-site: same-origin' -H 'sec-fetch-mode: cors' -H 'referer: https://cmcs.mram.gov.mn/cmcs' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __RequestVerificationToken_L0NNQ1M1=8Ch83z9AfrKm4Dvmr3Z6mVufh-bi7W_eAn_pL82bfzlqBMJv37zV5XQtnQINStjflP-e0WE38mYy9xtZRxo8UV1I1Oc1' --data 'indexType=10&_search=false&nd=1581438241776&rows=1000&page=1&sidx=Id&sord=desc' --compressed --insecure",
  special_state = "curl 'https://cmcs.mram.gov.mn/CMCS//SpecialArea/GridData' -H 'authority: cmcs.mram.gov.mn' -H 'accept: application/json, text/javascript, */*; q=0.01' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'origin: https://cmcs.mram.gov.mn' -H 'sec-fetch-site: same-origin' -H 'sec-fetch-mode: cors' -H 'referer: https://cmcs.mram.gov.mn/cmcs' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __RequestVerificationToken_L0NNQ1M1=8Ch83z9AfrKm4Dvmr3Z6mVufh-bi7W_eAn_pL82bfzlqBMJv37zV5XQtnQINStjflP-e0WE38mYy9xtZRxo8UV1I1Oc1' --data 'indexType=11&_search=false&nd=1581438279349&rows=1000&page=1&sidx=Id&sord=desc' --compressed --insecure",
  special_regional = "curl 'https://cmcs.mram.gov.mn/CMCS//SpecialArea/GridData' -H 'authority: cmcs.mram.gov.mn' -H 'accept: application/json, text/javascript, */*; q=0.01' -H 'x-requested-with: XMLHttpRequest' -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/79.0.3945.88 Safari/537.36' -H 'content-type: application/x-www-form-urlencoded; charset=UTF-8' -H 'origin: https://cmcs.mram.gov.mn' -H 'sec-fetch-site: same-origin' -H 'sec-fetch-mode: cors' -H 'referer: https://cmcs.mram.gov.mn/cmcs' -H 'accept-encoding: gzip, deflate, br' -H 'accept-language: en-US,en;q=0.9' -H 'cookie: __RequestVerificationToken_L0NNQ1M1=8Ch83z9AfrKm4Dvmr3Z6mVufh-bi7W_eAn_pL82bfzlqBMJv37zV5XQtnQINStjflP-e0WE38mYy9xtZRxo8UV1I1Oc1' --data 'indexType=12&_search=false&nd=1581438320404&rows=10000&page=1&sidx=Id&sord=desc' --compressed --insecure"
)

build_sa_df <- function(cmd, col_names = c("id", "code", "name", "status", "designation",
                                           "enacted_by","implementation", "expiry_date", 
                                           "area_hectares", "button")) {
  res <- system(cmd, intern = TRUE)
  parsed <- jsonlite::parse_json(res)

  data.table::rbindlist(
    lapply(parsed$rows, function(.x) {
      names(.x$cell) <- col_names
      .x$cell
    })
  )
  
}

all_sa_dfs <- lapply(curl_cmds, build_sa_df)

combo <- data.table::rbindlist(all_sa_dfs, use.names = TRUE, idcol = "special_area_type")

combo[, area_hectares := data.table::fifelse(nchar(area_hectares) == 0L,
                                           NA_real_, as.double(area_hectares))]

combo[, (c("implementation", "expiry_date")) := lapply(.SD, function(.x) {
  as.Date(.x, format = "%d/%m/%Y")
  }),
  .SDcols = c("implementation", "expiry_date")]

combo[, button := NULL]

cmcs_special_areas_df <- tibble::as_tibble(combo)

usethis::use_data(cmcs_special_areas_df, overwrite = TRUE)

