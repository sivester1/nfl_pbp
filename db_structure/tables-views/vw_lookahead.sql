CREATE OR REPLACE VIEW pbp.lookahead AS
 SELECT 2024 AS season,
    lookahead_2024.schedule_week,
    lookahead_2024.team_home,
    lookahead_2024.team_away,
    lookahead_2024.spread,
    lookahead_2024.total
   FROM lookahead_2024
UNION ALL
 SELECT 2025 AS season,
    lookahead_2025.schedule_week,
    lookahead_2025.team_home,
    lookahead_2025.team_away,
    lookahead_2025.spread,
    lookahead_2025.total
   FROM lookahead_2025;
