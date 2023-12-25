#!/usr/local/bin/Rscript

#.libPaths(c("C:/Users/steph/OneDrive/Documents/R/win-library/4.0", .libPaths()))

install.packages('nflreadr')
install.packages('nflfastR')
install.packages('rjson')
install.packages('RPostgreSQL')

library(nflreadr)
library(nflfastR)
library(rjson)
library(RPostgreSQL)

secret <- fromJSON(file = "~\\OneDrive\\Documents\\rstudio\\secret.json")
yr <- fromJSON(file = "~\\OneDrive\\Documents\\rstudio\\year.json")

tryCatch({
  drv <- dbDriver("PostgreSQL")
  print("Connecting to Database.")
  conn <- dbConnect(drv,
                    dbname = secret$dbname,
                    host = secret$host,
                    port = secret$port,
                    user = secret$username,
                    password = secret$password)
  print("Database Connected!")
},
error=function(cond) {
  print("Unable to connect to Database.")
  print(?message)
  quit(save = "no", status = 1, runLast = FALSE)
})

options(scipen = 9999)

data <- load_pbp(yr$year)

tb_name <- paste("plays_", yr$year, sep="")

sql_truncate <- paste("TRUNCATE ", tb_name)

res <- dbSendQuery(conn=conn, statement=sql_truncate)

output <- dbWriteTable(conn, tb_name, data, row.names=FALSE, append=TRUE)

if (output == TRUE) {
  print(paste0("Successfully updated the ", tb_name, " table!"))
} else {
  print("Table update failed!")
}
