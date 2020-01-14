gdp <- readRDS("../data/euro_gdp_clean.rds")

pdf("../output/euro_gdp_line_plot.pdf")
plot(gdp$obstime, gdp$obsvalue, type="l")
dev.off()
