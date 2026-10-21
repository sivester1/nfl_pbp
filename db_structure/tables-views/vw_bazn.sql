CREATE OR REPLACE VIEW pbp.bazn AS
 SELECT la.season,
    la.schedule_week,
    la.team_home AS team,
    la.team_away AS opp,
    hosr.play_type,
    round(bayzn(hosr.off_sr, adsr.def_sr), 5) AS bazn
   FROM lookahead la
     JOIN off_sr hosr ON hosr.posteam = la.team_home AND hosr.season = la.season
     JOIN def_sr adsr ON adsr.defteam = la.team_away AND adsr.season = la.season
  WHERE hosr.play_type = adsr.play_type
UNION ALL
 SELECT la.season,
    la.schedule_week,
    la.team_away AS team,
    la.team_home AS opp,
    aosr.play_type,
    round(bayzn(aosr.off_sr, hdsr.def_sr), 5) AS bazn
   FROM lookahead la
     LEFT JOIN off_sr aosr ON aosr.posteam = la.team_away AND aosr.season = la.season
     LEFT JOIN def_sr hdsr ON hdsr.defteam = la.team_home AND hdsr.season = la.season
  WHERE hdsr.play_type = aosr.play_type;
