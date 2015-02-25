set4Liebner <- c()
set4Liebner$intent2show <- c(T, T, T, T)
## intention 1: going straight >> done
## intention 2: stopping (basically: going straight and stop) >> done
## intention 3: turning >> done (could be better curve with desired velo model)
## intention 4: unlike paper!!!

set4Liebner$poscarryout <- -10 #any value on distance axis
set4Liebner$timelag <- -3 #must be zero or negative value

## when setting the timelag to 0
set4Liebner$cutdata <- T
set4Liebner$cutdata_time <- 1 #must be positive value

#set4Liebner$k <- c(13, 15, 18) # desired velocity models in ms

# load velocity models
data_u <- read.csv(paste("Liebner et al._2013/clustresults_means_", "h", ".txt",
                         sep = ""), header = T)

set4Liebner$k <- c(13, 15, 18) # desired velocity models in ms

set4Liebner$k1_clust <- data_u$values[which(data_u$clust_nr == 1)] # blue
set4Liebner$k2_clust <- data_u$values[which(data_u$clust_nr == 2)] # red
set4Liebner$k3_clust <- data_u$values[which(data_u$clust_nr == 3)] # green

set4Liebner$l <- c(1.5, 2, 2.5) # acceleration models in ms^2
set4Liebner$accexp <- 4 # acceleration exponent

set4Liebner$gap_distmin <- 2 # minimum gap in m to leading vehicle d0 = 2
set4Liebner$gap_timemin <- 0.8 # time gap in s to leading vehicle T = 0.8
set4Liebner$dec_b <- 3 # comfortable deceleration b

set4Liebner$objpos <- c(NA, -10, NA, -10)
