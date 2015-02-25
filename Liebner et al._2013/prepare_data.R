
# Load data ---------------------------------------------------------------

## source
set4query$src <- "t_can_full_aggr_dist_m_rnd1_max_dist2sxx_v2"

## filter
set4query$sxx   <- c(4)
set4query$subid <- c(1:31)
set4query$round <- c("normal", "stress")

## distance criteria
set4query$distvar <- "dist_m_rnd1"
set4query$dist1   <- "ind"
set4query$dist2   <- 25

## settings for dataframe
set4query$save2df_prefix <- "can"

## route related variables
set4query$var_session <-
  c("subid",
    "time_s",
    "time_s_rnd1",
    "dist_m_rnd1",
    "round_txt")

## situation related variables
set4query$var_sxx <-
  c("_dist_s_rnd1",
    "_dist_m_rnd1")

## CAN related variables
set4query$var_data <-
  c("speed_kmh",
    "acclong_ms2",
    "brakepress_bar",
    "steerangle_deg",
    "steerangle_speed",
    "accpedalpos_perc")

## Query data
dbQueryLoop(set4query)


# Data preparation --------------------------------------------------------

## interpolate for equal distances
intrpl4dist(set4query$save2df_prefix,
            set4query$distvar)

sxxVarRename()
