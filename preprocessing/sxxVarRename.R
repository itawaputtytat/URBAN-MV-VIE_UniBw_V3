
# Objective ---------------------------------------------------------------

## Change variable names from situation related variables


# Function ----------------------------------------------------------------

sxxVarRename <- function () {

  ## get data names in current workspace which containt pattern sxx
  datanames <-
    ls(env = .GlobalEnv)[grep( paste(sprintf("s%02d", 1:99),
                                     collapse = "|") ,
                               ls(env = .GlobalEnv))]

  for (dataname in datanames) {

    df <- get(dataname)
    varnames <- names(df)

    ## find situation naming pattern in variable names
    varfinder <- grep( paste(sprintf("s%02d", 1:99), collapse = "|"), varnames )

    # replace pattern with "sxx"
    for (var in varfinder) substr(varnames[var], 1, 3) <- "sxx"

    names(df) <- varnames

    assign(dataname, df, env = .GlobalEnv)
  }


}
