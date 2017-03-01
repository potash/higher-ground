drop table if exists parks;

create table parks as (
    select *
    from planet_osm_polygon
    where 
        leisure in ('park','nature_preserve') or
        landuse in ('conservation', 'forest') or
        ("natural" is not null and "natural" != 'water')
);

create index parks_index on parks using gist (way);
