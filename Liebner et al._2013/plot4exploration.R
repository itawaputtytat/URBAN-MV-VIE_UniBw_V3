
# Objective ---------------------------------------------------------------

## plot all trajectores from cluster analysis

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

plot(plotdata)
