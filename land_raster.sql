drop table if exists land_raster;

create table land_raster as (
    select st_asraster(geom,${WIDTH}, ${HEIGHT}, ARRAY['32BF']) rast
    from land
);
