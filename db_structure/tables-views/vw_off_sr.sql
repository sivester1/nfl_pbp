CREATE OR REPLACE VIEW pbp.off_sr AS
 SELECT offense_success.season,
    offense_success.posteam,
    offense_success.play_type,
    sum(offense_success.success_cnt) / sum(offense_success.plays_cnt) AS off_sr
   FROM offense_success
  GROUP BY offense_success.season, offense_success.posteam, offense_success.play_type
UNION ALL
 SELECT offense_success.season,
    offense_success.posteam,
    'overall'::text AS play_type,
    sum(offense_success.success_cnt) / sum(offense_success.plays_cnt) AS off_sr
   FROM offense_success
  GROUP BY offense_success.season, offense_success.posteam;
