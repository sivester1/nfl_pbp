Add this to your rc file to easily reload pbp data week-to-week

function load_pbp() {
	year=$1
	echo "{ \"year\": $year}" > ~/repo/nfl_pbp/r_to_pg/year.json;
	~/repo/nfl_pbp/r_to_pg/load_pbp_to_pg.R
}