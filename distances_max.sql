create table max_distances as (select distinct on (osm_id) osm_id, geom, distance, name from distances join parks on st_within(geom, way) where distance > 500 order by osm_id, distance desc);
