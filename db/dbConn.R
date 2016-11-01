# Resources ---------------------------------------------------------------

library(RPostgreSQL)


# Database settings -------------------------------------------------------

dbset <- c()
dbset$dns  <- NULL
dbset$host <- "localhost"
dbset$port <- 5432
dbset$name <- NULL
dbset$user <- NULL
dbset$pwd  <- NULL
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
