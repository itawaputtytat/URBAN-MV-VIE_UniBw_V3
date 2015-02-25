
# Objective ---------------------------------------------------------------

## starting point: time steps in raw data are not equal
## but e.g. cluster analysis needs equal time steps / distance values
## solution: template with full distance data
## ... and na.spline from package zoo interpolates these values


computeRoundDiff <- function (datanames_prefix,
                              datanames_suffix,
                              rounds,
                              varlist) {

  cat("Computing differences between rounds ...\n")
  cat(paste(c("normal", "stress"), collapse  = " vs. "), "\n\n")
  cat("for variables: \n")
  cat(paste("- ", varlist, sep = ""), sep = "\n")
  cat("\n")

  ## ---- Find data names -----

  ## get data names in current workspace
  datanames <- ls(envir = .GlobalEnv)

  ## select datanames which matches prefix, suffix and interpolation
  datanames <- datanames[which(grepl(datanames_prefix, datanames) &
                                 grepl(datanames_suffix, datanames) &
                                 grepl("intrpl", datanames) &
                                 grepl("diff", datanames) == F)]


  ## ----- Compute difference -----

  ## loop through list of names
  for (dataname in datanames) {

    cat(paste("current: ", dataname, "\n", sep = ""))

    ## create single dataframes for each round
    data_round1 <- get(dataname) %>% filter(round_txt == rounds[2])
    data_round2 <- get(dataname) %>% filter(round_txt == rounds[1])

    ## initiliaze variables for difference values
    diff_collector <- c()

    ## compute difference for each selected variable
    for (var in varlist) {
      diff_collector <- cbind(diff_collector,
                              data_round1[, var] - data_round2[, var])
    }
    diff_collector <- as.data.frame(diff_collector)
    names(diff_collector) <- paste(varlist, "_diff", sep = "")

    ## create new dataframe
    assign(paste(dataname, "rounddiff", sep ="_"),
           cbind(data_round1[1:2],
                 diff_collector),
           envir = .GlobalEnv)

  } #dataname
  cat("\n")
  cat("Done!")

}
