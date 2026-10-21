CREATE OR REPLACE VIEW pbp.yards_per_game AS
 WITH raw_data AS (
         SELECT p.game_id,
            p.season,
            p.week,
            p.home_team,
            p.away_team,
            p.fixed_drive,
            p.posteam,
            p.posteam_type,
            p.ydsnet AS offensive_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS pass_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS rush_yds,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN 1
                    ELSE 0
                END) AS rush_count
           FROM plays_2022 p
          WHERE p.posteam IS NOT NULL
          GROUP BY p.game_id, p.season, p.week, p.home_team, p.away_team, p.fixed_drive, p.posteam, p.posteam_type, p.ydsnet
        UNION ALL
         SELECT p.game_id,
            p.season,
            p.week,
            p.home_team,
            p.away_team,
            p.fixed_drive,
            p.posteam,
            p.posteam_type,
            p.ydsnet AS offensive_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS pass_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS rush_yds,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN 1
                    ELSE 0
                END) AS rush_count
           FROM plays_2023 p
          WHERE p.posteam IS NOT NULL
          GROUP BY p.game_id, p.season, p.week, p.home_team, p.away_team, p.fixed_drive, p.posteam, p.posteam_type, p.ydsnet
        UNION ALL
         SELECT p.game_id,
            p.season,
            p.week,
            p.home_team,
            p.away_team,
            p.fixed_drive,
            p.posteam,
            p.posteam_type,
            p.ydsnet AS offensive_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS pass_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS rush_yds,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN 1
                    ELSE 0
                END) AS rush_count
           FROM plays_2024 p
          WHERE p.posteam IS NOT NULL
          GROUP BY p.game_id, p.season, p.week, p.home_team, p.away_team, p.fixed_drive, p.posteam, p.posteam_type, p.ydsnet
        UNION ALL
         SELECT p.game_id,
            p.season,
            p.week,
            p.home_team,
            p.away_team,
            p.fixed_drive,
            p.posteam,
            p.posteam_type,
            p.ydsnet AS offensive_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS pass_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS rush_yds,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN 1
                    ELSE 0
                END) AS rush_count
           FROM plays_2025 p
          WHERE p.posteam IS NOT NULL
          GROUP BY p.game_id, p.season, p.week, p.home_team, p.away_team, p.fixed_drive, p.posteam, p.posteam_type, p.ydsnet
        UNION ALL
         SELECT p.game_id,
            p.season,
            p.week,
            p.home_team,
            p.away_team,
            p.fixed_drive,
            p.posteam,
            p.posteam_type,
            p.ydsnet AS offensive_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS pass_yds,
            sum(
                CASE
                    WHEN p.play_type = 'pass'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN p.yards_gained
                    ELSE NULL::double precision
                END) AS rush_yds,
            sum(
                CASE
                    WHEN p.play_type = 'run'::text THEN 1
                    ELSE 0
                END) AS rush_count
           FROM plays_2026 p
          WHERE p.posteam IS NOT NULL
          GROUP BY p.game_id, p.season, p.week, p.home_team, p.away_team, p.fixed_drive, p.posteam, p.posteam_type, p.ydsnet
        ), raw_points AS (
         SELECT DISTINCT all_plays.season,
            all_plays.week,
            all_plays.posteam,
            all_plays.fixed_drive,
            all_plays.fixed_drive_result,
                CASE
                    WHEN all_plays.fixed_drive_result = 'Touchdown'::text THEN 6
                    WHEN all_plays.fixed_drive_result = 'Field goal'::text THEN 3
                    ELSE NULL::integer
                END AS points
           FROM ( SELECT plays_2022.season,
                    plays_2022.week,
                    plays_2022.posteam,
                    plays_2022.fixed_drive,
                    plays_2022.fixed_drive_result
                   FROM plays_2022
                  WHERE plays_2022.posteam IS NOT NULL
                UNION ALL
                 SELECT plays_2023.season,
                    plays_2023.week,
                    plays_2023.posteam,
                    plays_2023.fixed_drive,
                    plays_2023.fixed_drive_result
                   FROM plays_2023
                  WHERE plays_2023.posteam IS NOT NULL
                UNION ALL
                 SELECT plays_2024.season,
                    plays_2024.week,
                    plays_2024.posteam,
                    plays_2024.fixed_drive,
                    plays_2024.fixed_drive_result
                   FROM plays_2024
                  WHERE plays_2024.posteam IS NOT NULL
                UNION ALL
                 SELECT plays_2025.season,
                    plays_2025.week,
                    plays_2025.posteam,
                    plays_2025.fixed_drive,
                    plays_2025.fixed_drive_result
                   FROM plays_2025
                  WHERE plays_2025.posteam IS NOT NULL
                UNION ALL
                 SELECT plays_2026.season,
                    plays_2026.week,
                    plays_2026.posteam,
                    plays_2026.fixed_drive,
                    plays_2026.fixed_drive_result
                   FROM plays_2026
                  WHERE plays_2026.posteam IS NOT NULL) all_plays
        ), adjusted_points AS (
         SELECT raw_points.season,
            raw_points.week,
            raw_points.posteam AS team,
            COALESCE(sum(raw_points.points), 0::bigint) AS points
           FROM raw_points
          GROUP BY raw_points.season, raw_points.week, raw_points.posteam
        ), staged_data AS (
         SELECT raw_data.game_id,
            raw_data.season,
            raw_data.week,
            raw_data.home_team AS team,
            'home'::text AS posteam_type,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.offensive_yds
                    ELSE NULL::double precision
                END) AS ttl_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.pass_yds
                    ELSE NULL::double precision
                END) AS ttl_pass_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.pass_count
                    ELSE NULL::bigint
                END) AS ttl_pass_count,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.rush_yds
                    ELSE NULL::double precision
                END) AS ttl_rush_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.rush_count
                    ELSE NULL::bigint
                END) AS ttl_rush_count,
            raw_data.away_team AS opponent,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.offensive_yds
                    ELSE NULL::double precision
                END) AS opp_ttl_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.pass_yds
                    ELSE NULL::double precision
                END) AS opp_ttl_pass_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.pass_count
                    ELSE NULL::bigint
                END) AS opp_ttl_pass_count,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.rush_yds
                    ELSE NULL::double precision
                END) AS opp_ttl_rush_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.rush_count
                    ELSE NULL::bigint
                END) AS opp_ttl_rush_count
           FROM raw_data
          GROUP BY raw_data.game_id, raw_data.season, raw_data.week, raw_data.home_team, raw_data.away_team
        UNION ALL
         SELECT raw_data.game_id,
            raw_data.season,
            raw_data.week,
            raw_data.away_team AS team,
            'away'::text AS posteam_type,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.offensive_yds
                    ELSE NULL::double precision
                END) AS ttl_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.pass_yds
                    ELSE NULL::double precision
                END) AS ttl_pass_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.pass_count
                    ELSE NULL::bigint
                END) AS ttl_pass_count,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.rush_yds
                    ELSE NULL::double precision
                END) AS ttl_rush_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'away'::text THEN raw_data.rush_count
                    ELSE NULL::bigint
                END) AS ttl_rush_count,
            raw_data.home_team AS opponent,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.offensive_yds
                    ELSE NULL::double precision
                END) AS opp_ttl_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.pass_yds
                    ELSE NULL::double precision
                END) AS opp_ttl_pass_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.pass_count
                    ELSE NULL::bigint
                END) AS opp_ttl_pass_count,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.rush_yds
                    ELSE NULL::double precision
                END) AS opp_ttl_rush_yds,
            sum(
                CASE
                    WHEN raw_data.posteam_type = 'home'::text THEN raw_data.rush_count
                    ELSE NULL::bigint
                END) AS opp_ttl_rush_count
           FROM raw_data
          GROUP BY raw_data.game_id, raw_data.season, raw_data.week, raw_data.away_team, raw_data.home_team
        )
 SELECT s.game_id,
    s.season,
    s.week,
    s.team,
    s.posteam_type,
    s.ttl_yds,
    s.ttl_pass_yds,
    s.ttl_pass_count,
    s.ttl_rush_yds,
    s.ttl_rush_count,
    s.opponent,
    s.opp_ttl_yds,
    s.opp_ttl_pass_yds,
    s.opp_ttl_pass_count,
    s.opp_ttl_rush_yds,
    s.opp_ttl_rush_count,
    a.points,
    b.points AS opp_points
   FROM staged_data s
     JOIN adjusted_points a ON s.team = a.team AND s.week = a.week AND s.season = a.season
     JOIN adjusted_points b ON s.opponent = b.team AND s.week = b.week AND s.season = b.season;
