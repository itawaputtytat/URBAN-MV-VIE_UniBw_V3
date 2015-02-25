# Objective ---------------------------------------------------------------

# After calling cluster analysis function (collection of algorithms)
# plot data


# Function ----------------------------------------------------------------

plotClustGroups <- function (data2plot) {

  plotdata <-
    ggplot(data2plot) +
    geom_line(aes_string(x = "temp_dist",
                         y = "temp_var2clust",
                         group = "temp_ident",
                         colour = "clust_nr")) +
    stat_summary(aes_string(x = "temp_dist",
                            y = "temp_var2clust"),
                 geom = "line",
                 fun.y = "mean",
                 colour = "black",
                 size = 1) +
    ggtitle(paste("algo: ", set$algo4clust, " in ", set$k, " groups \n",
                  "(crossings: ",
                  as.character(paste(set4query$sxx, collapse = ", ")),
                  ")", sep = "")) +
    labs(x = set$var4dist ,
         y = set$var2clust) +
    coord_cartesian(ylim = c(0, 17))

  return(plotdata)

}


