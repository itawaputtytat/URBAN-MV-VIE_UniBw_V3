
# Objective ---------------------------------------------------------------

## load data from database by looping through selected situations
## for each situation a dataframe gets creates


# Query loop --------------------------------------------------------------

dbQueryLoop <- function(set4query) {

  ptm <- proc.time()

  ## initialiae query string
  dbquery <<- c()

  cat("Query data from database... \n\n")

  for (sxx in set4query$sxx) {

    ## set name for dataframe
    dbquery$save2df <<- paste(sprintf("s%02d", sxx),
                               set4query$distvar,
                               sep = "_")

    if (is.null(set4query$save2df_prefix) == F)
      dbquery$save2df <<- paste(set4query$save2df_prefix,
                                 dbquery$save2df,
                                 sep = "_")

    ## print current query process
    cat(paste("into dataframe: ", dbquery$save2df, "\n", sep = ""))
    if (grepl("ind", set4query$dist1)) {

      dbGetSrc("sxx_critdist", "t_sxx_critdist")
      rowfinder <- which(sxx_critdist$situation == sxx)
      set4query$dist1 <- sxx_critdist$final[rowfinder] * (-1)

      cat("with individual distances \n")

    } else
      cat("with standard distances \n")

    cat(paste(" from ", set4query$distvar, " = ", set4query$dist1, "\n",
              " to   ",   set4query$distvar, " = ", set4query$dist2, "\n",
              sep = ""))

    ## create string for query
    dbQueryString(set4query, sxx)

    ## run query
    assign(dbquery$save2df,
           dbGetQuery(dbconn, dbquery$string),
           envir = .GlobalEnv)

    cat("\n")

  } # situation

  cat("\n")
  cat("Done!")
  cat("\n\n")
  cat("Overall time:", (proc.time() - ptm)[3], "s" )
  cat("\n\n")
}
