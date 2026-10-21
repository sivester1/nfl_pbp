## R to PostgreSQL

This folder contains R scripts for loading NFL play-by-play data into a PostgreSQL database. These scripts automate the process of importing and managing data.

### Contents
- **load_pbp_to_pg.R**: Main script for loading PBP data into PostgreSQL.
- **load_lookahead_to_pg.R**: Loads the current odds board (spread/total) for upcoming,
  not-yet-played games into `pbp.lookahead_<year>`. Unlike `load_pbp_to_pg.R` this is a
  point-in-time snapshot, not append-only history — rerun it to refresh as lines move
  during the week and as new weeks' games come into range.
- **year.json**: Configuration file for specifying the year of data to load.
- **secret.json**: Contains database connection credentials (ensure this file is secure).

### Usage
Add the following functions to your shell rc file to easily reload data week-to-week:
```bash
function load_pbp() {
	~/repo/nfl_pbp/r_to_pg/load_pbp_to_pg.R $1
}
function load_lookahead() {
	~/repo/nfl_pbp/r_to_pg/load_lookahead_to_pg.R $1
}
```
Call the scripts by running `load_pbp 2025` / `load_lookahead 2025` or any desired year.

After loading a new season's `lookahead_<year>` table for the first time, add a matching
`UNION ALL` arm to `pbp.lookahead` (and `pbp.bazn`, `pbp.bazn_past_5_wks`, `pbp.ypp`, which
depend on it) in `db_structure/tables-views/`.

create file `secret.json` with these details:

{
    "dbname": "pbp",
    "host" : "localhost",
    "port" : "5432",
    "username" : "pbp_worker",
    "password" : "madeuppassword"
}