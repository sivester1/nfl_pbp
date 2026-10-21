#!/usr/local/bin/Rscript

## Fetches the current odds board (spread/total) for upcoming, not-yet-played games and
## loads it into pbp.lookahead_<year>. Unlike load_pbp_to_pg.R this is a point-in-time
## snapshot, not append-only history -- rerun it to refresh as lines move during the week
## and as new weeks' games come into range.

library(nflreadr)
library(rjson)
library(RPostgreSQL)
library(DBI)


# Fetch db secrets and year passed from user
secret <- fromJSON(file = "~/repo/nfl_pbp/r_to_pg/secret.json")

# Capture year argument
yr <- as.integer(commandArgs(trailingOnly = TRUE))

if (length(yr) == 0) {
  stop("Error: No year argument provided. Please pass a year as a command-line argument.")
}
if (2000 < yr && yr < 2200) {
  message("Year argument received: ", yr)
} else {
  stop("Error: Invalid year argument provided. Please pass a valid year (e.g., 2026).")
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

options(scipen = 9999)


##########################
# FETCH UPCOMING SCHEDULE
#########################

sched <- load_schedules(yr)
upcoming <- sched[is.na(sched$result), c("week", "home_team", "away_team", "spread_line", "total_line")]
names(upcoming) <- c("schedule_week", "team_home", "team_away", "spread", "total")

if (nrow(upcoming) == 0) {
  message("No upcoming (unplayed) games found for ", yr, " -- nothing to load.")
  dbDisconnect(conn)
  quit(save = "no", status = 0, runLast = FALSE)
}

message("Found ", nrow(upcoming), " upcoming game(s) across week(s) ",
        paste(sort(unique(upcoming$schedule_week)), collapse = ", "))


######################
# LOAD INTO POSTGRES
#####################

tb_name <- paste0("lookahead_", yr)

# try to truncate the table (refreshes in place so existing grants/views keep working)
# if truncate fails, it doesn't exist yet -- create it

table_created <- tryCatch(
  {
    sql_truncate <- paste("TRUNCATE ", tb_name)
    res <- dbSendQuery(conn = conn, statement = sql_truncate)
    FALSE
  },
  error = function(e)
  {
    message(e$message)
    message(" Attempting to create table!")
    output <- dbWriteTable(conn, c("pbp", tb_name), upcoming, row.names = FALSE)
    if (output == TRUE) {
      message(paste0("  Successfully created & loaded the ", tb_name, " table!"))
    } else {
      message(" Table create failed!")
    }
    TRUE
  }
)

# new table already has the data loaded, so skip the append step below
if (!table_created) {
  output <- dbWriteTable(conn, tb_name, upcoming, row.names = FALSE, append = TRUE)

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
