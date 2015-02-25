
# Objective ---------------------------------------------------------------

## starting point: time steps in raw data are not equal
## but e.g. cluster analysis needs equal time steps / distance values
## solution: template with full distance data
## ... and na.spline from package zoo interpolates these values



# Function ----------------------------------------------------------------

intrpl4dist <- function (datanames_prefix, datanames_suffix) {

  require(zoo)

  ## ---- Peparatory settings -----

  ## which data should be interpolated?

  ## get data names in current workspace
  datanames <- ls(envir = .GlobalEnv)

  ## select datanames which matches prefix, suffix and no interpolation
  datanames <- datanames[which(grepl(datanames_prefix,
                                     ls(envir = .GlobalEnv)) &
                                 grepl(datanames_suffix,
                                       ls(envir = .GlobalEnv)) &
                                 grepl("intrpl",
                                       ls(envir = .GlobalEnv)) == F)]



  ## setting time step size
  set4intrpl <- c()
  if (grepl("0", datanames_suffix)) set4intrpl$step <- 1
  if (grepl("1", datanames_suffix)) set4intrpl$step <- 0.1


  ## ----- Process data -----

  cat("Processing... \n")

  ptm <- proc.time()

  ## loop through datanames
  for (dataname in datanames) {

    ## ----- Create template -----

    ## get current situation number by substr and using prefix
    temp_sxx  <- as.numeric(substr(dataname,
                                   nchar(datanames_prefix) + 3,
                                   nchar(datanames_prefix) + 4))

    print(temp_sxx)

    ## set start value for sequence by calling external data
    if (grepl("ind", set4query$dist1)) {
      rowfinder <- which(sxx_critdist$situation == temp_sxx)
      set4intrpl$dist1 <- sxx_critdist[rowfinder, "final"] * (-1)
    } else
      set4intrpl$dist1 <- set4query$dist1

    ## set end value for sequence
    set4intrpl$dist2   <- set4query$dist2

    ## create sequence
    set4intrpl$seq     <- seq(set4intrpl$dist1,
                              set4intrpl$dist2,
                              set4intrpl$step)

    ## set colname to corresponding situation
    set4intrpl$colname <- paste(sprintf("s%02d", temp_sxx),
                                datanames_suffix,
                                sep="_")

    ## create template
    template        <- data.frame(set4intrpl$seq)
    names(template) <- set4intrpl$colname

    ## ---- Merge template and data -----

    ## get data
    data       <- get(dataname, envir = .GlobalEnv)
    data$subid <- as.numeric(data$subid)

    collector4tempdata <- c()

    ## loop through each subid
    for (sid in unique(data$subid)) {
      ## loop trough each round
      for (rtxt in unique(data$round_txt)) {

        ## print current process
        cat("interpolating:", dataname, "\n",
            "subid:", sid ,"\n",
            "round:", rtxt, "\n\n")

        ## select data for current subid and round
        tempdata_subid <- data %>%
          filter(round_txt == rtxt, subid == sid)

        ## workaround for correct merging (due to missing values)
        tempdata_subid[, set4intrpl$colname] <-
          as.character(tempdata_subid[, set4intrpl$colname])

        template[,set4intrpl$colname] <-
          as.character(template[, set4intrpl$colname])

        ## merge template and subid data
        tempdata_merge <- left_join(template,
                                    tempdata_subid)
        cat("\n")

        tempdata_merge[, set4intrpl$colname] <-
          as.numeric(tempdata_merge[, set4intrpl$colname])

        ## code new variable as interpolated = T vs. F
        tempdata_merge$intrpl <- F


        ## identify rows with missing values and code as interpolated = T
        rows_without_data <- which(is.na(tempdata_merge$subid))
        tempdata_merge$intrpl[rows_without_data] <- T


        ## if interpolation is necessary (rows without data)
        if(length(rows_without_data) != 0) {
          cat("interpolating necessary \n")

          ## loop through all columns
          for (col in 2:(ncol(tempdata_merge) - 1)) {

            ## if current column contains a character value (e.g. code)
            ## ... fill all rows with the this character value
            if (is.character(tempdata_merge[, col]))

              ## take the only value that is not na
              tempdata_merge[, col] <-
              unique(tempdata_merge[, col])[which(
                is.na(unique(tempdata_merge[, col])) == F)]

            ## if current column contains numerics values
            ## ... apply na.spline from package zoo
            if (is.numeric(tempdata_merge[, col]))
              tempdata_merge[, col] <-
              na.spline(tempdata_merge[, col], x = tempdata_merge[, 1])

          } #na col
        } #length(rows_without_data)


        cat("before:", nrow(tempdata_subid),
            "vs. after:", nrow(tempdata_merge))
        cat("\n\n")


        ## collect data from each subid
        collector4tempdata <- rbind(collector4tempdata, tempdata_merge)

      } #rtxt
    } #sid

    ## create new dataframe with "intrpl" in name
    assign(paste(dataname, "intrpl", sep = "_"),
           collector4tempdata,
           envir = .GlobalEnv)

  } #nd

  cat("Done!")
  cat("\n\n")
  cat("Overall time:", (proc.time() - ptm)[3], "s" )
  cat("\n\n")
}
