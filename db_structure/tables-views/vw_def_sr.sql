CREATE OR REPLACE VIEW pbp.def_sr AS
 SELECT season,
    defteam,
    play_type,
    sum(success_cnt) / sum(plays_cnt) AS def_sr
   FROM defense_success
  GROUP BY season, defteam, play_type;
