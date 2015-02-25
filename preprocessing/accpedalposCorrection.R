
# Objective ---------------------------------------------------------------

# Adjust values for accelaration pedal position by value


# Function ----------------------------------------------------------------

accpedalposCorrection <- function() {

  # Correction value
  correction <- 14.901961

  datanames <- ls(env = .GlobalEnv)[which(grepl(set4query$save2data_prefix,
                                                ls(env = .GlobalEnv)) == T)]

  # Loop through data names
  for(dataname in datanames) {

    # Check if data frame already has corrected value
    column_checker <- which(names(get(dataname)) == "accpedalpos_perc_corr")

    # Add variable with corrected values
    if (length(column_checker) == 0) {

    data2correct <- get(dataname)

      assign(dataname,
             cbind(data2correct,
                   accpedalpos_perc_corr =
                     data2correct$accpedalpos_perc - correction),
             env = .GlobalEnv)

    } else #if column checker
      cat(paste("accpedalpos_perc in ", dataname, " already corrected \n", sep = ""))

  } #dataname
}
