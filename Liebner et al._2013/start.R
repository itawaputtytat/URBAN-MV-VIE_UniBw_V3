
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


# Preparation of simulation data ------------------------------------------

source("Liebner et al._2013/set4Liebner.R")

## Add velocity trajectories to data
data$k1 <- set4Liebner$k1_clust
data$k2 <- set4Liebner$k2_clust
data$k3 <- set4Liebner$k3_clust

## Explore data
source("Liebner et al._2013/plot4exploration.R")

## Preparation of simulation data
source("Liebner et al._2013/prepare_data4sim.R")


# Simulation --------------------------------------------------------------

## set intention
set4Liebner$intention <- 3

## run simulation
source("Liebner et al._2013/compute_sim.R")


# Visualize ---------------------------------------------------------------

source("Liebner et al._2013/plot4simulation.R")


