
# Objective ---------------------------------------------------------------

## Join all can data crossings


# Function ----------------------------------------------------------------

joinCrossings <- function() {

  ## find data names
  datanames <- ls(env = .GlobalEnv)
  datanames  <- datanames[which(grepl(set4query$save2df_prefix,
                                      ls(env = .GlobalEnv)) &
                           grepl(set4query$distvar,
                                 ls(env = .GlobalEnv)) &
                           grepl("intrpl",
                                 ls(env = .GlobalEnv)) &
                           grepl("rounddiff",
                                 ls(env = .GlobalEnv)) == F)]

  ## initialize data frame for collection
  collector <- c()

  ## loop through data names
  for(dataname in datanames) {

    ## get data
    df <- get(dataname)

    ## create variables vor situation identification
    df$sxx <- substr(dataname,
                     nchar(set4query$save2df_prefix) + 2,
                     nchar(set4query$save2df_prefix) + 4)

    ## create variable of individual situation identification
    df$crossing <-
      paste(sprintf("%02d", df$subid),
            df$sxx,
            df$round_txt,
            sep="_")

    collector <- rbind(collector, df)
  } #datanames

  return(collector)

}
