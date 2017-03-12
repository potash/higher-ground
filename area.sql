drop table if exists ${SCHEMA}.area;
create table ${SCHEMA}.area as (
    select st_collect(way) as geom
    from ${SCHEMA}.planet_osm_polygon 
    where ${LAND_CONDITION}
);
