gdp <- ecb::get_data("MNA.Q.Y.I8.W2.S1.S1.B.B1GQ._Z._Z._Z.EUR.LR.N")
saveRDS(gdp, file = "../output/euro_gdp.rds")


library(doFuture)
registerDoFuture()
cl <- makeCluster(10)
plan(cluster, workers = cl)

R <- 20
wait <- 10

tictoc::tic()
foreach(r = seq_len(R)) %dopar% {
  Sys.sleep(wait)
  print(paste("Iteration", r, "--- waiting", wait, "sec."))
}
tictoc::toc()

