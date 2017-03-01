drop table if exists parks;

create table parks as (
    select *
    from planet_osm_polygon
    where leisure = 'park'
    or "natural" is not null
);

create index parks_index on parks using gist (way);
