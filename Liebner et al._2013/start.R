

# Prepare data ------------------------------------------------------------

## Load data
#source("Liebner et al._2013/prepare_data.R")

can_crossings <- joinCrossings()

unique(can_crossings$crossing)
select_crossing <- "28_s04_normal"

## Load data
data <-
  can_crossings %>%
  filter(crossing == select_crossing,
         sxx_dist_m_rnd1 >= -50)

## Compute speed_ms
data$speed_ms <- data$speed_kmh / 3.6

## Visualization for exploration
plotdata <-
  ggplot() +
  geom_line(data = data,
            aes(x = sxx_dist_m_rnd1,
                y = speed_ms),
            size = 1) +
  coord_cartesian(xlim = c(-50, 25),
                  ylim = c(  0, 20))
plotdata


# Simulation settings -----------------------------------------------------

source("Liebner et al._2013/set4Liebner.R")

data$k1 <- set4Liebner$k1_clust
data$k2 <- set4Liebner$k2_clust
data$k3 <- set4Liebner$k3_clust

plotdata <-
  plotdata +
  geom_line(data = data,
            aes(x = sxx_dist_m_rnd1,
                y = k1),
            col = "red",
            size = 1) +
  geom_line(data = data,
            aes(x = sxx_dist_m_rnd1,
                y = k2),
            col = "green",
            size = 1) +
  geom_line(data = data,
            aes(x = sxx_dist_m_rnd1,
                y = k3),
            col = "blue",
            size = 1)
plotdata


# Preparation of simulation data ------------------------------------------

source("Liebner et al._2013/prepare_data4sim.R")


# Simulation --------------------------------------------------------------

## set intention
set4Liebner$intention <- 3

## run simulation
source("Liebner et al._2013/compute_sim.R")


# Visualize ---------------------------------------------------------------

plotdata_sim <-
  plotdata +

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

  geom_vline(aes(xintercept = set4Liebner$objpos[set4Liebner$intention]),
             colour = "red") +
  geom_line(data = datasim,
            aes(x = sxx_dist_m_rnd1,
                y = speed_ms,
                group = hypothesis,
                colour = hypothesis)) +
  scale_colour_manual(values = c(paste("red", c(1,3,4), sep = ""),
                                 paste("green", c(1,3,4), sep = ""),
                                 paste("blue", c(1,3,4), sep = "")))

plot(plotdata_sim)


