gdp <- ecb::get_data("MNA.Q.Y.I8.W2.S1.S1.B.B1GQ._Z._Z._Z.EUR.LR.N")
saveRDS(gdp, file = "../output/euro_gdp.rds")

