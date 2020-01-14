gdp <- readRDS("../data/euro_gdp.rds")

gdp <- gdp[c("obstime", "obsvalue")]
gdp$obstime <-
  zoo::as.Date(zoo::as.yearqtr(gdp$obstime, format="%Y-Q%q"), frac=1)

saveRDS(gdp, file="../data/euro_gdp_clean.rds")
