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


# Fetch db secrets and year passed from user
secret <- fromJSON(file = "~/repo/nfl_pbp/r_to_pg/secret.json")

# Capture year argument in json format
yr <- as.integer(commandArgs(trailingOnly = TRUE))

if (length(yr) == 0) {
  stop("Error: No year argument provided. Please pass a year as a command-line argument.")
}
if (2000 < yr && yr < 2200) {
  message("Year argument received: ", yr)
} else {
  stop("Error: Invalid year argument provided. Please pass a valid year (e.g., 2023).")
}


# Connect to Postgres DB
tryCatch({
  drv <- dbDriver("PostgreSQL")
  message("Connecting to Database.")
  conn <- dbConnect(drv,
                    dbname = secret$dbname,
                    host = secret$host,
                    port = secret$port,
                    user = secret$username,
                    password = secret$password)
  message("Database Connected!")
},
error=function(e) {
  message("Unable to connect to Database.")
  message(e$message)
  quit(save = "no", status = 1, runLast = FALSE)
})

# Set options to avoid scientific notation
options(scipen = 9999)


##########################
# LOAD FETCHES
#########################

# Each data load requires three components: 
#   1. a function to load the data (with tryCatch for error handling)
#   2. appending the loaded data to data_list
#   3. appending the corresponding table name to table_list


data_list <- list()
table_list <- list()

# add these three lines for each additional data load
pbp_data <- tryCatch(
  {
    load_pbp(yr)
  },
  error = function(e) {
    message("Error loading pbp data: - ", e$message)
  }
)
data_list <- append(data_list, list(pbp_data))
table_list <- append(table_list, paste("plays_", yr, sep = ""))


pfr_passing_data <- tryCatch(
  {
    load_pfr_advstats(yr)
  },
  error = function(e) {
    message("Error: ", e$message)
  }
)
data_list <- append(data_list, list(pfr_passing_data))
table_list <- append(table_list, paste("pfr_passing_", yr, sep = ""))


ff_opp_data <- tryCatch(
  {
    load_ff_opportunity(yr)
  },
  error = function(e) {
    message("Error: ", e$message)
  }
)
data_list <- append(data_list, list(ff_opp_data))
table_list <- append(table_list, paste("ff_opp_", yr, sep = ""))


ng_stats_data <- tryCatch(
  {
    load_nextgen_stats(yr)
  },
  error = function(e) {
    message("Error: ", e$message)
  }
)
data_list <- append(data_list, list(ng_stats_data))
table_list <- append(table_list, paste("ng_stats_", yr, sep = ""))

snap_counts_data <- tryCatch(
  {
    load_snap_counts(yr)
  },
  error = function(e) {
    message("Error: ", e$message)
  }
)
data_list <- append(data_list, list(snap_counts_data))
table_list <- append(table_list, paste("snap_counts_", yr, sep = ""))


if (length(data_list) != length(table_list)) {
  stop("Error: Length of data_list does not match length of table_list! Exiting script.")
}

######################
# LOAD INTO POSTGRES
#####################

# try to truncate the table
# this allows for views to persist on reload patterns
# if truncate fails, it might not exist (first time running script?)

for (i in seq_along(data_list)) {
  data <- data_list[[i]]
  tb_name <- table_list[[i]]
  
  message(paste0("Processing table: ", tb_name))

  tryCatch(
    {
      sql_truncate <- paste("TRUNCATE ", tb_name)
      res <- dbSendQuery(conn = conn, statement = sql_truncate)
    },
    error = function(e)
    { 
      message(e$message)
      message(" Attempting to create table!")
      output <- dbWriteTable(conn, c("pbp",tb_name), data, row.names=FALSE)
      if (output == TRUE) {
        message(paste0("  Successfully created & loaded the ", tb_name, " table!"))
      } else {
        message(" Table create failed!")
      }
      quit(save = "no", status = 1, runLast = FALSE)
      # new table so skipping write steps below
      next
    }
  )
  
  # load the data
  output <- dbWriteTable(conn, tb_name, data, row.names = FALSE, append = TRUE)
  
  if (output == TRUE) {
    message("  Update Successful")
    } else {
      message(" Update failed!")
  }
}

# Disconnect from the database
if (dbDisconnect(conn) == TRUE) {
  message("Database Disconnected Successfully.")
} else {
  message("Error disconnecting from Database.")
}
message("Script Complete.")
