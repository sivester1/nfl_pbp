CREATE OR REPLACE VIEW pbp.drives AS
 WITH a AS (
         SELECT p.season,
            p.week,
            p.game_id,
            p.fixed_drive,
            p.drive_play_count,
            p.drive_time_of_possession,
            p.posteam,
            'EDP Placeholder'::text AS edp,
            p.ydsnet,
            sum(
                CASE
                    WHEN p.yards_gained >= 20::double precision THEN 1
                    ELSE 0
                END) AS explosive_plays,
            p.fixed_drive_result,
            round(sum(p.wpa)::numeric, 2) AS wpa,
            p.home_team,
            round(max(p.home_wp)::numeric, 2) AS max_home_wp,
            p.away_team,
            round(max(p.away_wp)::numeric, 2) AS max_away_wp,
            COALESCE(sum(p.air_yards), 0::double precision) AS air_yards,
            COALESCE(sum(p.yards_after_catch), 0::double precision) AS yac,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'PASS'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'RUSH'::text THEN 1
                    ELSE 0
                END) AS run_count,
            'QB RUN placeholder'::text AS qb_run,
            p.drive_first_downs AS first_down_count,
            sum(
                CASE
                    WHEN p.down = 3::double precision THEN 1
                    ELSE 0
                END) AS third_down_count,
            p.drive_yards_penalized AS pnlty_yds
           FROM plays_2022 p
          WHERE p.play_type <> 'no_play'::text
          GROUP BY p.season, p.week, p.game_id, p.fixed_drive, p.drive_play_count, p.drive_time_of_possession, p.posteam, p.ydsnet, p.fixed_drive_result, p.home_team, p.away_team, p.drive_first_downs, p.drive_yards_penalized
        UNION ALL
         SELECT p.season,
            p.week,
            p.game_id,
            p.fixed_drive,
            p.drive_play_count,
            p.drive_time_of_possession,
            p.posteam,
            'EDP Placeholder'::text AS edp,
            p.ydsnet,
            sum(
                CASE
                    WHEN p.yards_gained >= 20::double precision THEN 1
                    ELSE 0
                END) AS explosive_plays,
            p.fixed_drive_result,
            round(sum(p.wpa)::numeric, 2) AS wpa,
            p.home_team,
            round(max(p.home_wp)::numeric, 2) AS max_home_wp,
            p.away_team,
            round(max(p.away_wp)::numeric, 2) AS max_away_wp,
            COALESCE(sum(p.air_yards), 0::double precision) AS air_yards,
            COALESCE(sum(p.yards_after_catch), 0::double precision) AS yac,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'PASS'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'RUSH'::text THEN 1
                    ELSE 0
                END) AS run_count,
            'QB RUN placeholder'::text AS qb_run,
            p.drive_first_downs AS first_down_count,
            sum(
                CASE
                    WHEN p.down = 3::double precision THEN 1
                    ELSE 0
                END) AS third_down_count,
            p.drive_yards_penalized AS pnlty_yds
           FROM plays_2023 p
          WHERE p.play_type <> 'no_play'::text
          GROUP BY p.season, p.week, p.game_id, p.fixed_drive, p.drive_play_count, p.drive_time_of_possession, p.posteam, p.ydsnet, p.fixed_drive_result, p.home_team, p.away_team, p.drive_first_downs, p.drive_yards_penalized
        UNION ALL
         SELECT p.season,
            p.week,
            p.game_id,
            p.fixed_drive,
            p.drive_play_count,
            p.drive_time_of_possession,
            p.posteam,
            'EDP Placeholder'::text AS edp,
            p.ydsnet,
            sum(
                CASE
                    WHEN p.yards_gained >= 20::double precision THEN 1
                    ELSE 0
                END) AS explosive_plays,
            p.fixed_drive_result,
            round(sum(p.wpa)::numeric, 2) AS wpa,
            p.home_team,
            round(max(p.home_wp)::numeric, 2) AS max_home_wp,
            p.away_team,
            round(max(p.away_wp)::numeric, 2) AS max_away_wp,
            COALESCE(sum(p.air_yards), 0::double precision) AS air_yards,
            COALESCE(sum(p.yards_after_catch), 0::double precision) AS yac,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'PASS'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'RUSH'::text THEN 1
                    ELSE 0
                END) AS run_count,
            'QB RUN placeholder'::text AS qb_run,
            p.drive_first_downs AS first_down_count,
            sum(
                CASE
                    WHEN p.down = 3::double precision THEN 1
                    ELSE 0
                END) AS third_down_count,
            p.drive_yards_penalized AS pnlty_yds
           FROM plays_2024 p
          WHERE p.play_type <> 'no_play'::text
          GROUP BY p.season, p.week, p.game_id, p.fixed_drive, p.drive_play_count, p.drive_time_of_possession, p.posteam, p.ydsnet, p.fixed_drive_result, p.home_team, p.away_team, p.drive_first_downs, p.drive_yards_penalized
        UNION ALL
         SELECT p.season,
            p.week,
            p.game_id,
            p.fixed_drive,
            p.drive_play_count,
            p.drive_time_of_possession,
            p.posteam,
            'EDP Placeholder'::text AS edp,
            p.ydsnet,
            sum(
                CASE
                    WHEN p.yards_gained >= 20::double precision THEN 1
                    ELSE 0
                END) AS explosive_plays,
            p.fixed_drive_result,
            round(sum(p.wpa)::numeric, 2) AS wpa,
            p.home_team,
            round(max(p.home_wp)::numeric, 2) AS max_home_wp,
            p.away_team,
            round(max(p.away_wp)::numeric, 2) AS max_away_wp,
            COALESCE(sum(p.air_yards), 0::double precision) AS air_yards,
            COALESCE(sum(p.yards_after_catch), 0::double precision) AS yac,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'PASS'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'RUSH'::text THEN 1
                    ELSE 0
                END) AS run_count,
            'QB RUN placeholder'::text AS qb_run,
            p.drive_first_downs AS first_down_count,
            sum(
                CASE
                    WHEN p.down = 3::double precision THEN 1
                    ELSE 0
                END) AS third_down_count,
            p.drive_yards_penalized AS pnlty_yds
           FROM plays_2025 p
          WHERE p.play_type <> 'no_play'::text
          GROUP BY p.season, p.week, p.game_id, p.fixed_drive, p.drive_play_count, p.drive_time_of_possession, p.posteam, p.ydsnet, p.fixed_drive_result, p.home_team, p.away_team, p.drive_first_downs, p.drive_yards_penalized
        UNION ALL
         SELECT p.season,
            p.week,
            p.game_id,
            p.fixed_drive,
            p.drive_play_count,
            p.drive_time_of_possession,
            p.posteam,
            'EDP Placeholder'::text AS edp,
            p.ydsnet,
            sum(
                CASE
                    WHEN p.yards_gained >= 20::double precision THEN 1
                    ELSE 0
                END) AS explosive_plays,
            p.fixed_drive_result,
            round(sum(p.wpa)::numeric, 2) AS wpa,
            p.home_team,
            round(max(p.home_wp)::numeric, 2) AS max_home_wp,
            p.away_team,
            round(max(p.away_wp)::numeric, 2) AS max_away_wp,
            COALESCE(sum(p.air_yards), 0::double precision) AS air_yards,
            COALESCE(sum(p.yards_after_catch), 0::double precision) AS yac,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'PASS'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type_nfl = 'RUSH'::text THEN 1
                    ELSE 0
                END) AS run_count,
            'QB RUN placeholder'::text AS qb_run,
            p.drive_first_downs AS first_down_count,
            sum(
                CASE
                    WHEN p.down = 3::double precision THEN 1
                    ELSE 0
                END) AS third_down_count,
            p.drive_yards_penalized AS pnlty_yds
           FROM plays_2026 p
          WHERE p.play_type <> 'no_play'::text
          GROUP BY p.season, p.week, p.game_id, p.fixed_drive, p.drive_play_count, p.drive_time_of_possession, p.posteam, p.ydsnet, p.fixed_drive_result, p.home_team, p.away_team, p.drive_first_downs, p.drive_yards_penalized
        )
 SELECT season,
    week,
    game_id,
    fixed_drive,
    drive_play_count,
    drive_time_of_possession,
    posteam,
    edp,
    ydsnet,
    explosive_plays,
    fixed_drive_result,
    wpa,
    home_team,
    max_home_wp,
    away_team,
    max_away_wp,
    air_yards,
    yac,
    pass_count,
    run_count,
    qb_run,
    first_down_count,
    third_down_count,
    pnlty_yds
   FROM a;
