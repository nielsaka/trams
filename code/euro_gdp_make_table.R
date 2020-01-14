gdp <- readRDS("../output/euro_gdp_clean.rds")


gdp_growth <- data.frame(time = gdp$obstime[-1], value = diff(log(gdp$obsvalue)) * 400)



kableExtra::
