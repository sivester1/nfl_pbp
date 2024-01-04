with raw_data as (
    select
        --game_id
        week
        , posteam
        --, play_id
        --, down
        , yards_gained
        , case when down=1 and yards_gained > ydstogo/2 then 1
            when down=2 and yards_gained > ydstogo*.7 then 1
            when down=3 and yards_gained >= ydstogo then 1
            when down=4 and yards_gained >= ydstogo then 1
            else 0 end as success 
		, epa
    , play_type 
    , pass_length
    , pass_location
    , run_location
    from plays_2023 
        where play_type in ('run','pass')
        and sp=0
        order by play_id
),
b as (
select 
  --week
 -- , game_id
  posteam
 -- , case when down <3 then 'early_down' else 'late_down' end as down
  , case when play_type = 'run' then COALESCE(play_type||'_'||run_location, '_fumble') else COALESCE(play_type||'_'||pass_length||'_'||pass_location,'_sack') end as detailed_play_type
  , avg(epa) as avg_epa
  , sum(yards_gained) as ttl_yds_gained
  , round(avg(success),3) as success_rate
  , count(*) as play_count
  from raw_data
  where week>(select max(week) from plays_2023)-5
  group by 1, 2)
, c as (
    select 
        posteam as offense
        , detailed_play_type
        , success_rate
		, round(avg_epa::decimal,2) as avg_epa
        , play_count
        , round(ttl_yds_gained::decimal/play_count::decimal,1) as avg_yds
        , DENSE_RANK() over (partition by detailed_play_type order by success_rate desc) as sr_rank
  from b
  order by posteam, sr_rank)
  , d as (
  	select 
  		offense
  		, detailed_play_type
  		, success_rate
  		, avg_epa
	    , play_count
  		, avg_yds
  		, sr_rank
  		, DENSE_RANK() over (partition by detailed_play_type order by play_count ) as play_rank
	from c)
  select 
    offense
    , detailed_play_type
    , success_rate
    , avg_epa
    , play_count
    , avg_yds
    , case when detailed_play_type in ('_fumble','_sack') then play_rank else sr_rank end as rank
      from d
  order by offense, detailed_play_type;
