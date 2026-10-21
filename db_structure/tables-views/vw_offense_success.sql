CREATE OR REPLACE VIEW pbp.offense_success AS
 WITH raw_data AS (
         SELECT p.season,
            p.game_id,
            p.week,
            p.posteam,
            p.down,
            p.yards_gained,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 1
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 1
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    ELSE 0
                END AS success,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 0
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 0
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    ELSE 1
                END AS failure,
            1 AS play_count,
            p.play_type,
            p.pass_length,
            p.pass_location,
            p.run_location
           FROM plays_2022 p
          WHERE (p.play_type = ANY (ARRAY['run'::text, 'pass'::text])) AND p.sp = 0::double precision AND p.down IS NOT NULL AND p.wp >= 0.05::double precision AND p.wp <= 0.95::double precision
        UNION ALL
         SELECT p.season,
            p.game_id,
            p.week,
            p.posteam,
            p.down,
            p.yards_gained,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 1
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 1
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    ELSE 0
                END AS success,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 0
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 0
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    ELSE 1
                END AS failure,
            1 AS play_count,
            p.play_type,
            p.pass_length,
            p.pass_location,
            p.run_location
           FROM plays_2023 p
          WHERE (p.play_type = ANY (ARRAY['run'::text, 'pass'::text])) AND p.sp = 0::double precision AND p.down IS NOT NULL AND p.wp >= 0.05::double precision AND p.wp <= 0.95::double precision
        UNION ALL
         SELECT p.season,
            p.game_id,
            p.week,
            p.posteam,
            p.down,
            p.yards_gained,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 1
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 1
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    ELSE 0
                END AS success,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 0
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 0
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    ELSE 1
                END AS failure,
            1 AS play_count,
            p.play_type,
            p.pass_length,
            p.pass_location,
            p.run_location
           FROM plays_2024 p
          WHERE (p.play_type = ANY (ARRAY['run'::text, 'pass'::text])) AND p.sp = 0::double precision AND p.down IS NOT NULL AND p.wp >= 0.05::double precision AND p.wp <= 0.95::double precision
        UNION ALL
         SELECT p.season,
            p.game_id,
            p.week,
            p.posteam,
            p.down,
            p.yards_gained,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 1
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 1
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    ELSE 0
                END AS success,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 0
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 0
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    ELSE 1
                END AS failure,
            1 AS play_count,
            p.play_type,
            p.pass_length,
            p.pass_location,
            p.run_location
           FROM plays_2025 p
          WHERE (p.play_type = ANY (ARRAY['run'::text, 'pass'::text])) AND p.sp = 0::double precision AND p.down IS NOT NULL AND p.wp >= 0.05::double precision AND p.wp <= 0.95::double precision
        UNION ALL
         SELECT p.season,
            p.game_id,
            p.week,
            p.posteam,
            p.down,
            p.yards_gained,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 1
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 1
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 1
                    ELSE 0
                END AS success,
                CASE
                    WHEN p.down = 1::double precision AND p.yards_gained > (p.ydstogo / 2::double precision) THEN 0
                    WHEN p.down = 2::double precision AND p.yards_gained > (p.ydstogo * 0.7::double precision) THEN 0
                    WHEN p.down = 3::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    WHEN p.down = 4::double precision AND p.yards_gained >= p.ydstogo THEN 0
                    ELSE 1
                END AS failure,
            1 AS play_count,
            p.play_type,
            p.pass_length,
            p.pass_location,
            p.run_location
           FROM plays_2026 p
          WHERE (p.play_type = ANY (ARRAY['run'::text, 'pass'::text])) AND p.sp = 0::double precision AND p.down IS NOT NULL AND p.wp >= 0.05::double precision AND p.wp <= 0.95::double precision
        )
 SELECT season,
    week,
    game_id,
    posteam,
    down,
    play_type,
    run_location,
    pass_location,
    pass_length,
    sum(success) AS success_cnt,
    sum(failure) AS failure_cnt,
    sum(play_count) AS plays_cnt
   FROM raw_data
  GROUP BY season, week, game_id, posteam, down, play_type, run_location, pass_location, pass_length
  ORDER BY season, week, posteam;
