CREATE OR REPLACE VIEW pbp.def_sr AS
 SELECT defense_success.season,
    defense_success.defteam,
    defense_success.play_type,
    sum(defense_success.success_cnt) / sum(defense_success.plays_cnt) AS def_sr
   FROM defense_success
  GROUP BY defense_success.season, defense_success.defteam, defense_success.play_type
UNION ALL
 SELECT defense_success.season,
    defense_success.defteam,
    'overall'::text AS play_type,
    sum(defense_success.success_cnt) / sum(defense_success.plays_cnt) AS def_sr
   FROM defense_success
  GROUP BY defense_success.season, defense_success.defteam;
