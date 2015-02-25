
# Database ----------------------------------------------------------------

## initialization of dbquery structure
dbquery <- c()

## intialise resources
source("db/dbConn.R")
source("db/dbListViews.R")
source("db/dbGetSrc.R")
source("db/dbQueryLoop.R")
source("db/dbQueryRun.R")
source("db/dbQueryString.R")


# Pre-Processing ----------------------------------------------------------

## initialize query settings
set4query <- c()

## libaries
library(dplyr)

## functions
source("preprocessing/intrpl4dist.R")
source("preprocessing/computeRoundDiff.R")
source("preprocessing/computeRoundDiff_ttest.R")
source("preprocessing/sxxVarRename.R")
source("preprocessing/accpedalposCorrection.R")



# Processing --------------------------------------------------------------

## initialize clustering settings
set4clust <- c()
source("processing/clust2groups.R")
source("processing//joinCrossings.R")


# Visualization -----------------------------------------------------------

library(ggplot2)

# initialization of plot settings
set4plot <- c()
set4plot$gtable_width <- readRDS("postprocessing//gtable_width.RDS")

# functions
source("postprocessing/adjustGrid.R")
source("postprocessing/adjustMarginGtable.R")
source("postprocessing/adjustPanel.R")
