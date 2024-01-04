CREATE OR REPLACE VIEW pbp.yards_per_game
 AS
 WITH raw_data AS (
         SELECT plays_2023.game_id,
            plays_2023.week,
            plays_2023.home_team,
            plays_2023.away_team,
            plays_2023.fixed_drive,
            plays_2023.posteam,
            plays_2023.posteam_type,
            plays_2023.ydsnet AS offensive_yds,
            sum(
                CASE
                    WHEN plays_2023.play_type = 'pass'::text THEN plays_2023.yards_gained
                    ELSE NULL::double precision
                END) AS pass_yds,
            sum(
                CASE
                    WHEN plays_2023.play_type = 'pass'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN plays_2023.play_type = 'run'::text THEN plays_2023.yards_gained
                    ELSE NULL::double precision
                END) AS rush_yds,
            sum(
                CASE
                    WHEN plays_2023.play_type = 'run'::text THEN 1
                    ELSE 0
                END) AS rush_count
           FROM plays_2023
          WHERE plays_2023.posteam IS NOT NULL
          GROUP BY plays_2023.game_id, plays_2023.week, plays_2023.home_team, plays_2023.away_team, plays_2023.fixed_drive, plays_2023.posteam, plays_2023.posteam_type, plays_2023.ydsnet
        ), raw_points AS (
         SELECT DISTINCT plays_2023.week,
            plays_2023.posteam,
            plays_2023.fixed_drive,
            plays_2023.fixed_drive_result,
                CASE
                    WHEN plays_2023.fixed_drive_result = 'Touchdown'::text THEN 6
                    WHEN plays_2023.fixed_drive_result = 'Field goal'::text THEN 3
                    ELSE NULL::integer
                END AS points
           FROM plays_2023
          WHERE 1 = 1 AND plays_2023.posteam IS NOT NULL
          ORDER BY plays_2023.posteam
        ), adjusted_points AS (
         SELECT raw_points.week,
            raw_points.posteam AS team,
            COALESCE(sum(raw_points.points), 0::bigint) AS points
           FROM raw_points
          GROUP BY raw_points.week, raw_points.posteam
          ORDER BY raw_points.week, (COALESCE(sum(raw_points.points), 0::bigint)) DESC
        ), staged_data AS (
         SELECT raw_data.game_id,
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
                END) AS _opp_ttl_pass_count,
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
          GROUP BY raw_data.game_id, raw_data.week, raw_data.home_team, 'home'::text, raw_data.away_team
        UNION ALL
         SELECT raw_data.game_id,
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
          GROUP BY raw_data.game_id, raw_data.week, raw_data.away_team, 'away'::text, raw_data.home_team
        )
 SELECT s.game_id,
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
    s._opp_ttl_pass_count,
    s.opp_ttl_rush_yds,
    s.opp_ttl_rush_count,
    a.points,
    b.points AS opp_points
   FROM staged_data s
     JOIN adjusted_points a ON s.team = a.team AND s.week = a.week
     JOIN adjusted_points b ON s.opponent = b.team AND s.week = b.week;