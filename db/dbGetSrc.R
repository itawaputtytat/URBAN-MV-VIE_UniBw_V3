dbGetSrc <- function(save2df, src) {

  dbquery$string <-
    paste("SELECT * FROM ", src, sep = "")

  dbQueryRun(save2df, dbquery$string)
}
