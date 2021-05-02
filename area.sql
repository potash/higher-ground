drop table if exists area;
create table area as (
    select st_collect(way) as geom
    from planet_osm_polygon 
    where ${LAND_CONDITION}
);
