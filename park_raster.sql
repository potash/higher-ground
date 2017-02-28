drop table if exists park_raster;

create table park_raster as (
    select ST_AsRaster(st_extent(way), 1024, 1024) rast
    FROM planet_osm_polygon
    where name = 'Chicago'
);
