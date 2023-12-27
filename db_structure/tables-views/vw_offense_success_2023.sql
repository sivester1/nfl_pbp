CREATE OR REPLACE VIEW pbp.offense_success_2023
 AS
 WITH raw_data AS (
         SELECT plays_2023.game_id,
            plays_2023.week,
            plays_2023.posteam,
            plays_2023.down,
            plays_2023.yards_gained,
                CASE
                    WHEN plays_2023.down = 1::double precision AND plays_2023.yards_gained > (plays_2023.ydstogo / 2::double precision) THEN 1
                    WHEN plays_2023.down = 2::double precision AND plays_2023.yards_gained > (plays_2023.ydstogo * 0.7::double precision) THEN 1
                    WHEN plays_2023.down = 3::double precision AND plays_2023.yards_gained >= plays_2023.ydstogo THEN 1
                    WHEN plays_2023.down = 4::double precision AND plays_2023.yards_gained >= plays_2023.ydstogo THEN 1
                    ELSE 0
                END AS success,
                CASE
                    WHEN plays_2023.down = 1::double precision AND plays_2023.yards_gained > (plays_2023.ydstogo / 2::double precision) THEN 0
                    WHEN plays_2023.down = 2::double precision AND plays_2023.yards_gained > (plays_2023.ydstogo * 0.7::double precision) THEN 0
                    WHEN plays_2023.down = 3::double precision AND plays_2023.yards_gained >= plays_2023.ydstogo THEN 0
                    WHEN plays_2023.down = 4::double precision AND plays_2023.yards_gained >= plays_2023.ydstogo THEN 0
                    ELSE 1
                END AS failure,
            1 AS play_count,
            plays_2023.play_type,
            plays_2023.pass_length,
            plays_2023.pass_location,
            plays_2023.run_location
           FROM plays_2023
          WHERE (plays_2023.play_type = ANY (ARRAY['run'::text, 'pass'::text])) AND plays_2023.sp = 0::double precision AND plays_2023.down IS NOT NULL
          ORDER BY plays_2023.play_id
        )
 SELECT raw_data.week,
    raw_data.game_id,
    raw_data.posteam,
    raw_data.down,
    raw_data.play_type,
    raw_data.run_location,
    raw_data.pass_location,
    raw_data.pass_length,
    sum(raw_data.success) AS success_cnt,
    sum(raw_data.failure) AS failure_cnt,
    sum(raw_data.play_count) AS plays_cnt
   FROM raw_data
  GROUP BY raw_data.week, raw_data.game_id, raw_data.posteam, raw_data.down, raw_data.play_type, raw_data.run_location, raw_data.pass_location, raw_data.pass_length
  ORDER BY raw_data.week, raw_data.posteam;