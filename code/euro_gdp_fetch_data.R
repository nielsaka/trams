gdp <- ecb::get_data("MNA.Q.Y.I8.W2.S1.S1.B.B1GQ._Z._Z._Z.EUR.LR.N")

R <- 20
wait <- 60

tictoc::tic()
for (r in seq_len(R)) {
  Sys.sleep(wait)
  print(paste("Iteration", r, "--- waiting", wait, "sec."))
}
tictoc::toc()

saveRDS(gdp, file = "../output/euro_gdp.rds")

