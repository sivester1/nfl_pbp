CREATE OR REPLACE VIEW pbp.ypp AS
 WITH ff_opp AS (
         SELECT ff_opp_2024.season::integer AS season,
            ff_opp_2024.posteam,
            ff_opp_2024.week,
            ff_opp_2024.rush_attempt,
            ff_opp_2024.rush_yards_gained,
            ff_opp_2024.rec_attempt,
            ff_opp_2024.rec_yards_gained
           FROM ff_opp_2024
        UNION ALL
         SELECT ff_opp_2025.season::integer AS season,
            ff_opp_2025.posteam,
            ff_opp_2025.week,
            ff_opp_2025.rush_attempt,
            ff_opp_2025.rush_yards_gained,
            ff_opp_2025.rec_attempt,
            ff_opp_2025.rec_yards_gained
           FROM ff_opp_2025
        UNION ALL
         SELECT ff_opp_2026.season::integer AS season,
            ff_opp_2026.posteam,
            ff_opp_2026.week,
            ff_opp_2026.rush_attempt,
            ff_opp_2026.rush_yards_gained,
            ff_opp_2026.rec_attempt,
            ff_opp_2026.rec_yards_gained
           FROM ff_opp_2026
        ), week_data AS (
         SELECT fo.season,
            fo.posteam,
                CASE
                    WHEN lh.team_home = fo.posteam THEN lh.team_away
                    ELSE la.team_home
                END AS defteam,
            fo.week,
            sum(fo.rush_attempt) AS rush,
            sum(fo.rush_yards_gained) AS rush_yds,
            sum(fo.rec_attempt) AS pass,
            sum(fo.rec_yards_gained) AS pass_yds
           FROM ff_opp fo
             LEFT JOIN lookahead lh ON fo.season = lh.season AND fo.week = lh.schedule_week::double precision AND fo.posteam = lh.team_home
             LEFT JOIN lookahead la ON fo.season = la.season AND fo.week = la.schedule_week::double precision AND fo.posteam = la.team_away
          GROUP BY fo.season, fo.posteam, (
                CASE
                    WHEN lh.team_home = fo.posteam THEN lh.team_away
                    ELSE la.team_home
                END), fo.week
        ), ttl_wk AS (
         SELECT week_data.season,
            week_data.posteam,
            week_data.defteam,
            week_data.week,
            week_data.rush,
            week_data.rush_yds,
            week_data.pass,
            week_data.pass_yds,
            sum(week_data.rush + week_data.pass) AS plays,
            sum(week_data.rush_yds + week_data.pass_yds) AS ttl_yds
           FROM week_data
          GROUP BY week_data.season, week_data.posteam, week_data.defteam, week_data.week, week_data.rush, week_data.rush_yds, week_data.pass, week_data.pass_yds
        )
 SELECT season,
    posteam,
    defteam,
    week,
    rush,
    rush_yds,
    pass,
    pass_yds,
    plays,
    ttl_yds,
    round(rush_yds::numeric / rush::numeric, 1) AS rush_yds_per_play,
    round(pass_yds::numeric / pass::numeric, 1) AS pass_yds_per_play,
    round(ttl_yds::numeric / plays::numeric, 1) AS ttl_yds_per_play
   FROM ttl_wk
  ORDER BY season, week;
