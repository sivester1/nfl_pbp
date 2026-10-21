CREATE OR REPLACE VIEW pbp.vegas_lines AS
 WITH all_plays AS (
         SELECT plays_2022.season,
            plays_2022.week,
            plays_2022.home_team,
            plays_2022.away_team,
            plays_2022.home_score,
            plays_2022.away_score,
            plays_2022.total_line,
            plays_2022.spread_line,
            plays_2022.location,
            plays_2022.result,
            plays_2022.total
           FROM plays_2022
        UNION ALL
         SELECT plays_2023.season,
            plays_2023.week,
            plays_2023.home_team,
            plays_2023.away_team,
            plays_2023.home_score,
            plays_2023.away_score,
            plays_2023.total_line,
            plays_2023.spread_line,
            plays_2023.location,
            plays_2023.result,
            plays_2023.total
           FROM plays_2023
        UNION ALL
         SELECT plays_2024.season,
            plays_2024.week,
            plays_2024.home_team,
            plays_2024.away_team,
            plays_2024.home_score,
            plays_2024.away_score,
            plays_2024.total_line,
            plays_2024.spread_line,
            plays_2024.location,
            plays_2024.result,
            plays_2024.total
           FROM plays_2024
        UNION ALL
         SELECT plays_2025.season,
            plays_2025.week,
            plays_2025.home_team,
            plays_2025.away_team,
            plays_2025.home_score,
            plays_2025.away_score,
            plays_2025.total_line,
            plays_2025.spread_line,
            plays_2025.location,
            plays_2025.result,
            plays_2025.total
           FROM plays_2025
        UNION ALL
         SELECT plays_2026.season,
            plays_2026.week,
            plays_2026.home_team,
            plays_2026.away_team,
            plays_2026.home_score,
            plays_2026.away_score,
            plays_2026.total_line,
            plays_2026.spread_line,
            plays_2026.location,
            plays_2026.result,
            plays_2026.total
           FROM plays_2026
        )
 SELECT DISTINCT season,
    week,
    home_team,
    away_team,
    home_score,
    away_score,
    (total_line + spread_line) / 2::double precision AS home_implied,
    (total_line - spread_line) / 2::double precision AS away_implied,
    location,
    result,
    spread_line,
        CASE
            WHEN spread_line = result::double precision THEN 'PUSH'::text
            WHEN spread_line > 0::double precision AND result::double precision > spread_line THEN 'FAVORITE'::text
            WHEN spread_line < 0::double precision AND result::double precision < spread_line THEN 'FAVORITE'::text
            ELSE 'UNDERDOG'::text
        END AS spread_result,
    total,
    total_line,
        CASE
            WHEN (home_score + away_score)::double precision = total_line THEN 'PUSH'::text
            WHEN (home_score + away_score)::double precision < total_line THEN 'U'::text
            ELSE 'O'::text
        END AS total_result,
        CASE
            WHEN spread_line > 0::double precision AND home_score > away_score THEN 'FAVORITE'::text
            WHEN spread_line < 0::double precision AND away_score > home_score THEN 'FAVORITE'::text
            ELSE 'UNDERDOG'::text
        END AS abs_result
   FROM all_plays
  ORDER BY week, home_team;
