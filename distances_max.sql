drop table if exists ${SCHEMA}.max_distances;

create table ${SCHEMA}.max_distances as (
    select distinct on (osm_id) osm_id, geom, distance, name 
    from ${SCHEMA}.distances join ${SCHEMA}.parks on st_within(geom, way) 
    where distance > 500 order by osm_id, distance desc
);
