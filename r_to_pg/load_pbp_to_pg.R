#!/usr/local/bin/Rscript

## NOTES 
## I had to modify my hba.conf from SCRAM to md5 before this would work
## `SCRAM authentication requires libpq version 10 or above` <- error
## log into db and query `SHOW hba_file;` to find the location of dba.conf file
## after modifying, bounce the db server
## `sudo -u postgres pg_ctl -D /Library/PostgreSQL/16/data restart`
## then change your db password (you have to choose a different pw then change back to original)

## Had to do this in the past on windows  
#.libPaths(c("C:/Users/steph/OneDrive/Documents/R/win-library/4.0", .libPaths()))

## first time installs - uncomment the first run 
#install.packages('nflreadr',    repos = "http://cran.us.r-project.org")
#install.packages('nflfastR',    repos = "http://cran.us.r-project.org")
#install.packages('rjson',       repos = "http://cran.us.r-project.org")
#install.packages('RPostgreSQL', repos = "http://cran.us.r-project.org")
#install.packages("DBI",         repos = "http://cran.us.r-project.org")

library(nflreadr)
library(nflfastR)
library(rjson)
library(RPostgreSQL)
library(DBI)

secret <- fromJSON(file = "~/repo/nfl_pbp/r_to_pg/secret.json")
yr <- fromJSON(file = "~/repo/nfl_pbp/r_to_pg/year.json")

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
error=function(e) {
  print("Unable to connect to Database.")
  print(e$message)
  quit(save = "no", status = 1, runLast = FALSE)
})

options(scipen = 9999)

data <- load_pbp(yr$year)

tb_name <- paste("plays_", yr$year, sep="")

# try to truncate the table
# this allows for views to persist on reload patterns 
# if truncate fails, it might not exist (first time running script?)
tryCatch(
  {
    sql_truncate <- paste("TRUNCATE ", tb_name)
    res <- dbSendQuery(conn=conn, statement=sql_truncate)
  },
  error = function(e)
  { 
    print(e$message)
    print("*************************************")
    print("Attempting to create/recreate table!")
    print("*************************************")
    output <- dbWriteTable(conn, c("pbp",tb_name), data, row.names=FALSE)
    if (output == TRUE) {
      print(paste0("Successfully created & loaded the ", tb_name, " table!"))
    } 
    else {
      print("Table create failed!")
    }
    quit(save = "no", status = 1, runLast = FALSE)
  }
)

# if we've made it this far, let's load some data
output <- dbWriteTable(conn, tb_name, data, row.names=FALSE, append=TRUE)

if (output == TRUE) {
  print(paste0("Successfully updated the ", tb_name, " table!"))
  } else {
    print("Table update failed!")
}
