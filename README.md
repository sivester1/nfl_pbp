## NFL Play-by-Play (PBP) Data

This repository contains tools and resources for working with NFL play-by-play data. The structure is organized into several subfolders, each serving a specific purpose. Below are descriptions and links to each subfolder:

### Subfolders

- [db_structure](db_structure/): Contains database metadata and table/view definitions for managing NFL PBP data.
- [py_notebooks](py_notebooks/): Includes Jupyter Notebooks for data analysis and visualization.
- [queries](queries/): Stores SQL queries for analyzing NFL PBP data.
- [r_to_pg](r_to_pg/): Contains R scripts for loading NFL PBP data into a PostgreSQL database.

Refer to the README files in each subfolder for more details.

## Fetch R datasets and load into Postgres

Add this to your rc file to easily reload pbp data week-to-week
```
function load_pbp() {
	~/repo/nfl_pbp/r_to_pg/load_pbp_to_pg.R $1
}
```
call script by running `load_pbp 2025` or whatever year you desire
