
# Objective ---------------------------------------------------------------

## ttest of round-diff values against zero (no difference)


# Function ----------------------------------------------------------------

computeRoundDiff_ttest <- function(data2explore,
                                   dist2explore,
                                   var2explore) {

  ## create template of distinct distances
  distances <- unique(get(data2explore)[, dist2explore])

  ## compute t-test for each distance step
  pcollector <- c()
  for (dist in distances) {

    ## select data for corresponding distance
    temp_data <- get(data2explore)
    rowfinder <- which(temp_data[, dist2explore] == dist)
    temp_data <- temp_data[rowfinder, var2explore]

    ## compute t-test against zero
    test <- t.test(temp_data, mu = 0, nr.rm = T, silent = T)

    ## collect p-values
    p <- test$p.value
    pcollector <- c(pcollector, test$p.value)
  }

  ## merge to source
  assign(paste(data2explore, "_ttest", sep = ""),
         data.frame(src = data2explore,
                    distance = distances,
                    p = pcollector),
         env = .GlobalEnv)

}


