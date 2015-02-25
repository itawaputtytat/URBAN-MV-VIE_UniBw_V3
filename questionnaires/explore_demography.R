
# Objective ---------------------------------------------------------------

## Exploration of demography data


# Data preparation --------------------------------------------------------

## Load data
data <- dbGetSrc("v_q_demography_personal")

data$drivingstyle <- factor(data$drivingstyle,
                            levels = c(1:5),
                            labels = c("very sporty",
                                       "sporty",
                                       "balanced",
                                       "comfortable",
                                       "very comfortable"))

data$gender <- factor(data$gender, levels = c("w", "m"))


# Data exploration --------------------------------------------------------

ggplot() +
  geom_bar(data = data,
           aes(drivingstyle),
           width = 0.5) +
  geom_bar(data = data,
           aes(drivingstyle,
               fill = gender),
           position="dodge") +
  scale_x_discrete(drop = FALSE) +
  coord_cartesian(ylim = c(0, 30))

## Idea: Categorize in sporty and non-sporty
data$drivingstyle_sporty <- c()
data$drivingstyle_sporty[as.numeric(data$drivingstyle) >= 3] <- 0
data$drivingstyle_sporty[as.numeric(data$drivingstyle) <= 2] <- 1
data$drivingstyle_sporty <- factor(data$drivingstyle_sporty,
                                   labels = c("non-sporty", "sporty"))

ggplot() +
  geom_bar(data = data,
           aes(drivingstyle_sporty),
           width = 0.5) +
  geom_bar(data = data,
           aes(drivingstyle_sporty,
               fill = gender),
           position="dodge") +
  coord_cartesian(ylim = c(0, 30))
