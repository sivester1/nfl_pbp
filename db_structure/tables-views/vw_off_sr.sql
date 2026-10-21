CREATE OR REPLACE VIEW pbp.off_sr AS
 SELECT season,
    posteam,
    play_type,
    sum(success_cnt) / sum(plays_cnt) AS off_sr
   FROM offense_success
  GROUP BY season, posteam, play_type;
