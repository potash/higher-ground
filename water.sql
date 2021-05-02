drop table if exists water;

create table water as (
    select way as geom, 
        planet_osm_polygon.*
    from planet_osm_polygon, area
    where st_intersects(way, area.geom) and coalesce(leisure != 'marina', true) and (
    water is not null
    or "natural" = 'water'
    or waterway is not null
    )
);

create index water_index on water using gist (way);
