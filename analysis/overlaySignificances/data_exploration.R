#source("analysis/overlaySignificances/data_preparation.R")

# Exploration -------------------------------------------------------------

dist2explore <- "sxx_dist_m_rnd1"
var2explore  <- "steerangle_deg_diff"

# plotdata <-
#   ggplot() +
#   geom_line(data = get(data2explore),
#             aes_string(x = dist2explore,
#                        y = var2explore,
#                        group = "subid")) +
#   stat_summary(data = get(data2explore),
#                aes_string(x = dist2explore,
#                           y = var2explore),
#                fun.y = mean,
#                geom = "line",
#                colour = "red",
#                size = 1)
# plotdata


# Compute t-test ----------------------------------------------------------

datanames <- ls(envir = .GlobalEnv)
datanames <- datanames[which(grepl(set4query$save2df_prefix,
                                   ls(envir = .GlobalEnv)) &
                               grepl(set4query$distvar,
                                     ls(envir = .GlobalEnv)) &
                               grepl("rounddiff",
                                     ls(envir = .GlobalEnv)) &
                               grepl("ttest",
                                     ls(envir = .GlobalEnv)) == F)]

data_joined <- c()
for (dataname in datanames) {
  computeRoundDiff_ttest(dataname, dist2explore, var2explore)
  data_joined <- rbind(data_joined, get(paste(dataname, "_ttest", sep = "")))
}

plotdata <-
  ggplot(data = data_joined) +
  geom_rect(aes(xmin = -Inf,
                xmax =  Inf,
                ymin = 0.05,
                ymax = 0.1),
            fill = "yellow",
            alpha = 0.25) +
  geom_rect(aes(xmin = -Inf,
                xmax =  Inf,
                ymin = 0,
                ymax = 0.05),
            fill = "green",
            alpha = 0.25) +
  geom_line(data = data_joined,
            aes(x = distance,
                y = p,
                group = src,
                colour = src)) +
  facet_grid(src~.) +
  theme(legend.position="none")

ggsave(paste(var2explore, ".png", sep = ""),
       plotdata,
       height = 50, width = 20, units = "cm", dpi = 300)
