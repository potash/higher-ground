drop table if exists ${SCHEMA}.parks;

create table ${SCHEMA}.parks as (
    select *
    from ${SCHEMA}.planet_osm_polygon
    where 
        leisure in ('park','nature_preserve') or
        landuse in ('conservation', 'forest') or
        ("natural" is not null and "natural" != 'water')
);

create index parks_index on ${SCHEMA}.parks using gist (way);
