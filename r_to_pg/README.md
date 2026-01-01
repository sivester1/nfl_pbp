## R to PostgreSQL

This folder contains R scripts for loading NFL play-by-play data into a PostgreSQL database. These scripts automate the process of importing and managing data.

### Contents
- **load_pbp_to_pg.R**: Main script for loading PBP data into PostgreSQL.
- **year.json**: Configuration file for specifying the year of data to load.
- **secret.json**: Contains database connection credentials (ensure this file is secure).

### Usage
Add the following function to your shell rc file to easily reload PBP data week-to-week:
```bash
function load_pbp() {
	~/repo/nfl_pbp/r_to_pg/load_pbp_to_pg.R $1
}
```
Call the script by running `load_pbp 2025` or any desired year.

create file `secret.json` with these details:

{
    "dbname": "pbp",
    "host" : "localhost",
    "port" : "5432",
    "username" : "pbp_worker",
    "password" : "madeuppassword"
}