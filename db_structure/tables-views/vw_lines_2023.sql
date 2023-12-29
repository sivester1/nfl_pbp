create or replace view pbp.lines_2023 as (
    with raw_data as (
        select distinct
            week
            , home_team as team
            , away_team as opponent
            , home_score as score
            , 'home' as team_type
            , lower(location) as location
            , total
            , spread_line as closing_spread
            , total_line as ou_line
            , (total_line + spread_line)/2 as implied_score
            , (total_line - spread_line)/2 as opp_implied_score
            , away_score as opp_score
        from plays_2023 
        union all 
        select distinct
            week
            , away_team as team
            , home_team as opponent
            , away_score as score
            , 'away' as team_type
            , lower(case when location='Home' then 'away' else location end) as location
            , total
            , spread_line as closing_spread
            , total_line as ou_line
            , (total_line - spread_line)/2 as implied_score
            , (total_line + spread_line)/2 as opp_implied_score
            , home_score as opp_score
        from plays_2023 
    )
    select 
        week
        , team
        , score 
        , implied_score
        , score - implied_score as poe
        , total
        , ou_line 
        , case 
            when total > ou_line then 'o' 
            when total < ou_line then 'u'
            else 'push' 
        end as ou
        , opponent
        , opp_score
        , opp_implied_score
        , opp_score - opp_implied_score as opp_poe
    from raw_data
);