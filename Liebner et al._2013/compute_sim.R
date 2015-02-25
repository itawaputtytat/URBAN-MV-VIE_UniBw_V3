## initialize final dataframe for simulation
datasim <- c()

## loop through velocity models
for(k in 1:length(set4Liebner$k)) {

  ## loop through acceleration models
  for(l in 1:length(set4Liebner$l)) {




    objpos <- set4Liebner$objpos[set4Liebner$intention]

    ## Initialize dataframe
    sim <- data.frame(hypothesis      = paste("k", k, "_l", l, sep = ""),
                      time_s_rnd1     = data4sim$time_s_rnd1,
                      sxx_dist_m_rnd1 = 0,
                      speed_ms        = 0,
                      acclong_ms2     = 0,
                      u               = data4sim[,paste("k", k, sep = "")])

    sim$sxx_dist_m_rnd1[1] <- data4sim$sxx_dist_m_rnd1[1]
    sim$speed_ms[1] <- data4sim$speed_ms[1]
    sim$acclong_ms2[1] <- data4sim$acclong_ms2[1]

    ## loop through rows of dataframe
    for(row in 2:nrow(sim)) {

      ## compute difference of data steps for acceleration adjustments
      timediff <- sim$time_s_rnd1[row] - sim$time_s_rnd1[row-1]

      ## get value of velocity and acceleration values
      if(set4Liebner$intention %in% c(1,2)) u <- set4Liebner$k[k] else
        u <- sim$u[row]
        a <- set4Liebner$l[l]

      if(!is.na(objpos)) {

        # compute gap values
        gap_desired <-
          set4Liebner$gap_distmin +
          (set4Liebner$gap_timemin * sim$speed_ms[row-1]) +
          ( (sim$speed_ms[row-1]^2) / (2 * (l * set4Liebner$dec_b)^(1/2) ) )

        gap_actual  <- sim$sxx_dist_m_rnd1[row-1] - objpos
        gap_term    <- (gap_desired/gap_actual)^2

      } else gap_term <- 0

      ## compute new acceleration
      sim$acclong_ms2[row] <-
        a * timediff * ( (1- (sim$speed_ms[row-1] / u)^set4Liebner$accexp ) - gap_term )

      ## compute new spred
      sim$speed_ms[row] <- sim$speed_ms[row - 1] + sim$acclong_ms2[row]

      ## compute new distance
      sim$sxx_dist_m_rnd1[row] <-
        sim$sxx_dist_m_rnd1[row-1] + sim$speed_ms[row] * timediff

    } #row
    datasim <- rbind(datasim, sim)
  } #l
} #k
