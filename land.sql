drop table if exists land;
create table land as (

select st_union(way) as geom 
from planet_osm_polygon 
where ${LAND_CONDITION}

);
