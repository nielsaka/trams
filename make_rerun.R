maker <- function(added, deleted, modified) {
  system("bib-copy.bat")
  system("make")
  TRUE
}
testthat::watch(path = list.dirs(getwd()), callback = maker)