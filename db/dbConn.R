# Resources ---------------------------------------------------------------

library(RPostgreSQL)


# Database settings -------------------------------------------------------

dbset <- c()
dbset$dns  <- "VIE_2013"
dbset$host <- "localhost"
dbset$port <- 5432
dbset$name <- "VIE_2013"
dbset$user <- "postgres"
dbset$pwd  <- "keines"
dbset$drv  <- dbDriver("PostgreSQL")


# Connect to database -----------------------------------------------------

dbConn <- function() {

  dbconn <<-
  dbConnect(dbset$drv,
            host    = dbset$host,
            port     = dbset$port,
            dbname   = dbset$name,
            user     = dbset$user,
            password = dbset$pwd)

}

dbConn()

#dbDisconnect(dbconn)
#dbUnloadDriver(dbset$drv)
