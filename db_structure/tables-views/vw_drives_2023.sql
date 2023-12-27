CREATE OR REPLACE VIEW pbp.drives_2023
 AS
 WITH a AS (
         SELECT plays_2023.week,
            plays_2023.game_id,
            plays_2023.fixed_drive,
            plays_2023.drive_play_count,
            plays_2023.drive_time_of_possession,
            plays_2023.posteam,
            'EDP Placeholder'::text AS edp,
            plays_2023.ydsnet,
            sum(
                CASE
                    WHEN plays_2023.yards_gained >= 20::double precision THEN 1
                    ELSE 0
                END) AS explosive_plays,
            plays_2023.fixed_drive_result,
            round(sum(plays_2023.wpa)::numeric, 2) AS wpa,
            plays_2023.home_team,
            round(max(plays_2023.home_wp)::numeric, 2) AS max_home_wp,
            plays_2023.away_team,
            round(max(plays_2023.away_wp)::numeric, 2) AS max_away_wp,
            COALESCE(sum(plays_2023.air_yards), 0::double precision) AS air_yards,
            COALESCE(sum(plays_2023.yards_after_catch), 0::double precision) AS yac,
            sum(
                CASE
                    WHEN plays_2023.play_type_nfl = 'PASS'::text THEN 1
                    ELSE 0
                END) AS pass_count,
            sum(
                CASE
                    WHEN plays_2023.play_type_nfl = 'RUSH'::text THEN 1
                    ELSE 0
                END) AS run_count,
            'QB RUN placeholder'::text AS qb_run,
            plays_2023.drive_first_downs AS first_down_count,
            sum(
                CASE
                    WHEN plays_2023.down = 3::double precision THEN 1
                    ELSE 0
                END) AS third_down_count,
            plays_2023.drive_yards_penalized AS pnlty_yds
           FROM plays_2023
          WHERE 1 = 1 AND plays_2023.play_type <> 'no_play'::text
          GROUP BY plays_2023.week, plays_2023.game_id, plays_2023.fixed_drive, plays_2023.drive_play_count, plays_2023.drive_time_of_possession, plays_2023.posteam, 'EDP Placeholder'::text, plays_2023.ydsnet, plays_2023.fixed_drive_result, plays_2023.home_team, plays_2023.away_team, 'QB RUN placeholder'::text, plays_2023.drive_first_downs, plays_2023.drive_yards_penalized
          ORDER BY plays_2023.week, plays_2023.game_id, plays_2023.fixed_drive
        )
 SELECT a.week,
    a.game_id,
    a.fixed_drive,
    a.drive_play_count,
    a.drive_time_of_possession,
    a.posteam,
    a.edp,
    a.ydsnet,
    a.explosive_plays,
    a.fixed_drive_result,
    a.wpa,
    a.home_team,
    a.max_home_wp,
    a.away_team,
    a.max_away_wp,
    a.air_yards,
    a.yac,
    a.pass_count,
    a.run_count,
    a.qb_run,
    a.first_down_count,
    a.third_down_count,
    a.pnlty_yds
   FROM a;