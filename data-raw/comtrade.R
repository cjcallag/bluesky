library(comtradr)

all_commods <- comtradr:::get_commodity_db()[-(1:5), ]$code

split_commods <- function(x) {
  n <- length(x) / 20
  split(
    x, 
    cut(seq_along(x), 
        quantile(seq_along(x), (0:n) / n),
        include.lowest = TRUE, labels = FALSE)
  )
}

commod_queries <- split_commods(all_commods)

init <- vector(mode = "list", length = length(commod_queries))
failures <- NULL

for (i in seq_along(commod_queries)) {
  queries_remaining <- ct_get_remaining_hourly_queries()
  
  while (queries_remaining < 3) {
    Sys.sleep(60)
    cat("\r- sleeping...")
    queries_remaining <- ct_get_remaining_hourly_queries()
  }
  
  Sys.sleep(3)
  cat(sprintf("\r - fetching query # %d / %s ...", i, length(commod_queries)))

  init[[i]] <- tryCatch(
    comtradr::ct_search(
      reporters = "All", partners = "Mongolia",
      start_date = 2015, end_date = 2019,
      commod_codes = commod_queries[[i]]
    ),
    error = function(e) {
      message(sprintf("query # %d failed...\n", i))
      # message(e)
      failures <- c(failures, i)
      NULL
    }
  )
}

comtrade <- data.table::rbindlist(init)

usethis::use_data(comtrade, overwrite = TRUE)

