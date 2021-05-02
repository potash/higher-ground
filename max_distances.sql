drop table if exists max_distances;

create table max_distances as (
    select distinct on (osm_id) osm_id, geom, distance, name 
    from distances join parks on st_within(geom, way) 
    where distance > 5000 and name is not null
    order by osm_id, distance desc
);
