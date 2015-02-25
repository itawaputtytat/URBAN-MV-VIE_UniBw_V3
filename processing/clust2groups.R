# Objective ---------------------------------------------------------------
# Use available algo2use kmeans++

# Rescources --------------------------------------------------------------

# for kmeanspp
library(LICORS)

# for hclust
library("dtw")
library(TSclust) # for calculating distance
set4clust$method_dist   = "DTW"
set4clust$method_hclust = "ward.D"


# Function ----------------------------------------------------------------

clust2groups <- function(data_wide, kgroups, algo2use) {

  cat(paste("Clusteranalysis using ", algo2use,
            " in ", kgroups, " groups ... \n", sep = ""))

  set.seed(set4clust$seed)

  # ---- kmeans -----
  if (algo2use == "kmeans") {

    clust_result<-
      kmeans(data_wide,
             centers   = set4clust$k,
             iter.max  = 500,
             nstart    = 1,
             algorithm = "Hartigan-Wong")


    #new table for subids and corresponding cluster-nr
    clust_groups <-
      data.frame(temp_ident = rownames(data_wide),
                 clust_nr   = factor(clust_result$cluster),
                 row.names  = NULL)

    # Convert identity variable to character for potential merging
    clust_groups$temp_ident <-
      as.character(clust_groups$temp_ident)

  }


  # ----- kmeanspp -----
  if (algo2use == "kmeanspp") {

    # Call algo2use
    clust_result <-
      kmeanspp(data_wide,
               k = kgroups,
               start = "random",
               iter.max = 500,
               nstart = 1,
               algorithm = "Hartigan-Wong")


    # New table for group membership
    clust_groups <-
      data.frame(temp_ident = rownames(data_wide),
                 clust_nr   = factor(clust_result$cluster),
                 row.names  = NULL)

    # Convert identity variable to character for potential merging
    clust_groups$temp_ident <-
      as.character(clust_groups$temp_ident)

  }


  # ---- hclust # ----
  if (algo2use == "hclust") {

    # Compute distance matrix using package TSclust
    # Dissimilariy matrix using "DTW"
    #data2clust_wide_t <- t(data_wide)
    clust_h_dist <- diss(as.matrix(data_wide), set4clust$method_dist)

    # Additional information to algorithm
    algo2use <- paste(algo2use, "( ",
                      "dist.=", set4clust$method_dist, ";",
                      "agglo.=", set4clust$method_hclust,
                      ")")

    # Call algo2use
    clust_result <-
      hclust(clust_h_dist,
             method = set4clust$method_hclust)

    #new table for subids and corresponding cluster-nr
    clust_groups <-
      data.frame(temp_ident = rownames(data_wide),
                 clust_nr   = factor(cutree(clust_result, k = set4clust$k)),
                 row.names  = NULL)

    # Convert identity variable to character for potential merging
    clust_groups$temp_ident <-
      as.character(clust_groups$temp_ident)

  }

  cat("Done!")

  return (list(algorithm = algo2use,
               result = clust_result,
               groups = clust_groups))

}









#
#
# #join data and cluster-nr
# data_clust_kmeanspp <-
#   left_join(data2clust,
#             clust_kmeanspp_groups,
#             by = "temp_ident")
#
# data_clust_kmeanspp$clust_nr <- factor(data_clust_kmeanspp$clust_nr)
#
# #plot data
# data_plot <-
#   ggplot(data_clust_kmeanspp) +
#   geom_line(aes_string(x = "temp_dist",
#                        y = "temp_var2clust",
#                        group = "temp_ident",
#                        colour = "clust_nr")) +
#   stat_summary(aes_string(x = "temp_dist",
#                           y = "temp_var2clust"),
#                geom = "line",
#                fun.y = "mean",
#                colour = "black",
#                size = 1) +
#   ggtitle(paste("kmeanspp", set4clust$k, "(", set4clust$var2clust , ")", sep = "")) +
#   coord_cartesian(ylim = c(0, 17))
# #dev.new(); data_plot
# dev.new(); data_plot + facet_grid(.~clust_nr)
#
# #plotting cluster solutions
#
# dev.new()
# clusplot(data2clust_wide, clust_kmeanspp$cluster,
#          colour = T,
#          shade = T,
#          labels = 2,
#          cex = 0.75,
#          lines = 0)
#
# library(fpc)
# #dev.new(); plotcluster(data2clust_wide, clust_kmeanspp$cluster)
#
# #validating cluster solutions
# data_dist_eucl <- dist(data2clust_wide, method = "euclidean")
# cluster.stats(data_dist_eucl, clust_kmeanspp$cluster)

#rm(clust_kmeans, clust_kmeanspp_groups, data_clust_kmeanspp, data_plot)
