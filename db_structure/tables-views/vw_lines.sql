CREATE OR REPLACE VIEW pbp.lines AS
 WITH raw_data AS (
         SELECT DISTINCT p.season,
            p.week,
            p.home_team AS team,
            p.away_team AS opponent,
            p.home_score AS score,
            'home'::text AS team_type,
            lower(p.location) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line + p.spread_line) / 2::double precision AS implied_score,
            (p.total_line - p.spread_line) / 2::double precision AS opp_implied_score,
            p.away_score AS opp_score
           FROM plays_2022 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.away_team AS team,
            p.home_team AS opponent,
            p.away_score AS score,
            'away'::text AS team_type,
            lower(
                CASE
                    WHEN p.location = 'Home'::text THEN 'away'::text
                    ELSE p.location
                END) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line - p.spread_line) / 2::double precision AS implied_score,
            (p.total_line + p.spread_line) / 2::double precision AS opp_implied_score,
            p.home_score AS opp_score
           FROM plays_2022 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.home_team AS team,
            p.away_team AS opponent,
            p.home_score AS score,
            'home'::text AS team_type,
            lower(p.location) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line + p.spread_line) / 2::double precision AS implied_score,
            (p.total_line - p.spread_line) / 2::double precision AS opp_implied_score,
            p.away_score AS opp_score
           FROM plays_2023 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.away_team AS team,
            p.home_team AS opponent,
            p.away_score AS score,
            'away'::text AS team_type,
            lower(
                CASE
                    WHEN p.location = 'Home'::text THEN 'away'::text
                    ELSE p.location
                END) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line - p.spread_line) / 2::double precision AS implied_score,
            (p.total_line + p.spread_line) / 2::double precision AS opp_implied_score,
            p.home_score AS opp_score
           FROM plays_2023 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.home_team AS team,
            p.away_team AS opponent,
            p.home_score AS score,
            'home'::text AS team_type,
            lower(p.location) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line + p.spread_line) / 2::double precision AS implied_score,
            (p.total_line - p.spread_line) / 2::double precision AS opp_implied_score,
            p.away_score AS opp_score
           FROM plays_2024 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.away_team AS team,
            p.home_team AS opponent,
            p.away_score AS score,
            'away'::text AS team_type,
            lower(
                CASE
                    WHEN p.location = 'Home'::text THEN 'away'::text
                    ELSE p.location
                END) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line - p.spread_line) / 2::double precision AS implied_score,
            (p.total_line + p.spread_line) / 2::double precision AS opp_implied_score,
            p.home_score AS opp_score
           FROM plays_2024 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.home_team AS team,
            p.away_team AS opponent,
            p.home_score AS score,
            'home'::text AS team_type,
            lower(p.location) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line + p.spread_line) / 2::double precision AS implied_score,
            (p.total_line - p.spread_line) / 2::double precision AS opp_implied_score,
            p.away_score AS opp_score
           FROM plays_2025 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.away_team AS team,
            p.home_team AS opponent,
            p.away_score AS score,
            'away'::text AS team_type,
            lower(
                CASE
                    WHEN p.location = 'Home'::text THEN 'away'::text
                    ELSE p.location
                END) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line - p.spread_line) / 2::double precision AS implied_score,
            (p.total_line + p.spread_line) / 2::double precision AS opp_implied_score,
            p.home_score AS opp_score
           FROM plays_2025 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.home_team AS team,
            p.away_team AS opponent,
            p.home_score AS score,
            'home'::text AS team_type,
            lower(p.location) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line + p.spread_line) / 2::double precision AS implied_score,
            (p.total_line - p.spread_line) / 2::double precision AS opp_implied_score,
            p.away_score AS opp_score
           FROM plays_2026 p
        UNION ALL
         SELECT DISTINCT p.season,
            p.week,
            p.away_team AS team,
            p.home_team AS opponent,
            p.away_score AS score,
            'away'::text AS team_type,
            lower(
                CASE
                    WHEN p.location = 'Home'::text THEN 'away'::text
                    ELSE p.location
                END) AS location,
            p.total,
            p.spread_line AS closing_spread,
            p.total_line AS ou_line,
            (p.total_line - p.spread_line) / 2::double precision AS implied_score,
            (p.total_line + p.spread_line) / 2::double precision AS opp_implied_score,
            p.home_score AS opp_score
           FROM plays_2026 p
        )
 SELECT season,
    week,
    team,
    score,
    implied_score,
    score::double precision - implied_score AS poe,
    total,
    ou_line,
        CASE
            WHEN total::double precision > ou_line THEN 'o'::text
            WHEN total::double precision < ou_line THEN 'u'::text
            ELSE 'push'::text
        END AS ou,
    opponent,
    opp_score,
    opp_implied_score,
    opp_score::double precision - opp_implied_score AS opp_poe,
    team_type,
    location
   FROM raw_data;
