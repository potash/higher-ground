drop table if exists ${SCHEMA}.water;

create table ${SCHEMA}.water as (
    select st_intersection(way, area.geom) geom, planet_osm_polygon.*
    from ${SCHEMA}.planet_osm_polygon, ${SCHEMA}.area
    where st_intersects(way, area.geom) and coalesce(leisure != 'marina', true) and (
    water is not null
    or "natural" = 'water'
    or waterway is not null
    )
);

create index water_index on ${SCHEMA}.water using gist (way);
