gdp <- readRDS("../output/euro_gdp_clean.rds")

pdf("../output/euro_gdp_plot_line.pdf")
plot(gdp$obstime, gdp$obsvalue, type="l")
dev.off()

