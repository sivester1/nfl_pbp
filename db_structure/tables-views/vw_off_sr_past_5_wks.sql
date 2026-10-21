CREATE OR REPLACE VIEW pbp.off_sr_past_5_wks AS
 SELECT season,
    posteam,
    play_type,
    sum(success_cnt) / sum(plays_cnt) AS off_sr
   FROM ( SELECT offense_success.season,
            offense_success.week,
            offense_success.game_id,
            offense_success.posteam,
            offense_success.down,
            offense_success.play_type,
            offense_success.run_location,
            offense_success.pass_location,
            offense_success.pass_length,
            offense_success.success_cnt,
            offense_success.failure_cnt,
            offense_success.plays_cnt,
            max(offense_success.week) OVER (PARTITION BY offense_success.season) AS season_max_week
           FROM offense_success) os
  WHERE week > (season_max_week - 5)
  GROUP BY season, posteam, play_type;
