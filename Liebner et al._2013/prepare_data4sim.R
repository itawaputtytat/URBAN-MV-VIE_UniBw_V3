cat(paste("Simulation carried out at position: ",
          set4Liebner$poscarryout, " m \n",
          sep = ""))

## Find nearest distance to criteria
dist_rowfinder <- which(data$sxx_dist_m_rnd1 == set4Liebner$poscarryout)

## In case of several rows matching the distance criteria
## = take value with minimum deviation
dist_rowfinder <-
  dist_rowfinder[
    which(abs(data$sxx_dist_m_rnd1[dist_rowfinder] - set4Liebner$poscarryout) ==
            min(abs(data$sxx_dist_m_rnd1[dist_rowfinder] - set4Liebner$poscarryout)))]


if (set4Liebner$timelag != 0) {

  cat(paste("... with time lag of: ", set4Liebner$timelag, " s\n", sep = ""))

  ## Find corresponding time to distance of carrying the simulation
  set4Liebner$time1 <- data$time_s_rnd1[dist_rowfinder] + set4Liebner$timelag
  time_rowfinder <- which(round(data$time_s_rnd1) == round(set4Liebner$time1))

  ## In case of several rows matching the time criteria
  time_rowfinder <-
    time_rowfinder[
      which(abs(data$time_s[time_rowfinder] - set4Liebner$time1) ==
              min(abs(data$time_s[time_rowfinder] - set4Liebner$time1)))]

  set4Liebner$time1 <- data$time_s[time_rowfinder]
  set4Liebner$dist1 <- data$sxx_dist_m_rnd1[time_rowfinder]

  cat(paste("... which corresponds to the position: ",
            set4Liebner$dist1, " m \n",
            sep = ""))

  ## Find corresponding time to distance nearest to criteria (end)
  ## cp. above; here without addition of timelag
  set4Liebner$time2 <- data$time_s_rnd1[dist_rowfinder]
  time_rowfinder <- which(round(data$time_s_rnd1) == round(set4Liebner$time2))

  ## In case of several rows matching the time criteria
  time_rowfinder <-
    time_rowfinder[
      which(abs(data$time_s_rnd1[time_rowfinder] - set4Liebner$time2) ==
              min(abs(data$time_s_rnd1[time_rowfinder] - set4Liebner$time2)))]

  set4Liebner$time2 <- data$time_s_rnd1[time_rowfinder]

  ## create new data set dependet on cutting data setting
  if(set4Liebner$cutdata)
    data4sim <- data %>%
      filter(time_s_rnd1 >= set4Liebner$time1 &
               sxx_dist_m_rnd1 <= set4Liebner$poscarryout) else
    data4sim <- data %>%
      filter(time_s_rnd1 >= set4Liebner$time1)

  #  set4Liebner$poscarryout_time <- data_sim$sxx_dist_m[1]

} else { # select data section without time lag

  ## Find corresponding time to distance of carrying the simulation
  set4Liebner$time2 <- data$time_s_rnd1[dist_rowfinder] + set4Liebner$cutdata_time
  time_rowfinder <- which(round(data$time_s_rnd1) == round(set4Liebner$time2))

  ## In case of several rows matching the time criteria
  time_rowfinder <-
    time_rowfinder[which(abs(data$time_s_rnd1[time_rowfinder] - set4Liebner$time2) ==
              min(abs(data$time_s_rnd1[time_rowfinder] - set4Liebner$time2)))]

  ## create new data set dependingh on cutting data setting
  if(set4Liebner$cutdata) {

    cat(paste("Cutting data after: ", set4Liebner$cutdata_time, " s \n", sep = ""))

    data4sim <-
      data %>%
      filter(sxx_dist_m_rnd1 >= set4Liebner$poscarryout &
               time_s_rnd1 <= set4Liebner$time2)

  } else {
    data4sim <- data %>%
      filter(sxx_dist_m_rnd1 >= set4Liebner$poscarryout)
  }

}
