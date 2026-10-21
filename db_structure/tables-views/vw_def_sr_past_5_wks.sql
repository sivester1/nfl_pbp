CREATE OR REPLACE VIEW pbp.def_sr_past_5_wks AS
 SELECT season,
    defteam,
    play_type,
    sum(success_cnt) / sum(plays_cnt) AS def_sr
   FROM ( SELECT defense_success.season,
            defense_success.week,
            defense_success.game_id,
            defense_success.defteam,
            defense_success.down,
            defense_success.play_type,
            defense_success.run_location,
            defense_success.pass_location,
            defense_success.pass_length,
            defense_success.success_cnt,
            defense_success.failure_cnt,
            defense_success.plays_cnt,
            max(defense_success.week) OVER (PARTITION BY defense_success.season) AS season_max_week
           FROM defense_success) ds
  WHERE week > (season_max_week - 5)
  GROUP BY season, defteam, play_type;
