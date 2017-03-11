drop table if exists area;
create table area as (
with land as (
    select st_collect(way) as geom
    from planet_osm_polygon 
    where ${LAND_CONDITION}
)

select * from land

);
