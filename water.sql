drop table if exists water;

create table water as (
    select *
    from planet_osm_polygon
    where 
    water is not null
    or "natural" = 'water'
    or leisure = 'marina'
    or waterway is not null
);

create index water_index on water using gist (way);
