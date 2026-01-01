Add this to your rc file to easily reload pbp data week-to-week

function load_pbp() {
	~/repo/nfl_pbp/r_to_pg/load_pbp_to_pg.R $1
}

call script by running `load_pbp 2025` or whatever year you desire
