
# Objective ---------------------------------------------------------------

## Plot simulated data

plotdata_sim <-
  plotdata +

  ## Show position where simulation is carried out
  geom_vline(aes(xintercept = set4Liebner$poscarryout)) +
  geom_rect(aes(xmin = set4Liebner$poscarryout - 6,
                xmax = set4Liebner$poscarryout + 6,
                ymin = 0, ymax = 1),
            fill = "grey70") +
  geom_text(aes(x = set4Liebner$poscarryout,
                y = 0.5,
                label = paste("simulation carried out at: \n",
                              set4Liebner$poscarryout, " m", sep = ""),
                fontface = "bold")) +

  ## Show position of time lag (where simulation begins)
  geom_rect(aes(xmin = min(datasim$sxx_dist_m_rnd1),
                xmax = set4Liebner$poscarryout,
                ymin = 1.1, ymax = 2.1),
            fill = "grey80") +
  geom_text(aes(x = (min(datasim$sxx_dist_m_rnd1) + (set4Liebner$poscarryout))/2,
                y = 1.6,
                label = paste("simulation starting:\n",
                              set4Liebner$timelag, " s in past", sep = ""),
                fontface = "bold")) +
  geom_vline(aes(xintercept = min(datasim$sxx_dist_m_rnd1))) +

  ## Show position of zero-velocity object
  geom_vline(aes(xintercept = set4Liebner$objpos[set4Liebner$intention]),
             colour = "red") +
  geom_line(data = datasim,
            aes(x = sxx_dist_m_rnd1,
                y = speed_ms,
                group = hypothesis,
                colour = hypothesis)) +

  ## Adjust colours
  scale_colour_manual(values = c(paste("red", c(1,3,4), sep = ""),
                                 paste("green", c(1,3,4), sep = ""),
                                 paste("blue", c(1,3,4), sep = "")))

plot(plotdata_sim)
