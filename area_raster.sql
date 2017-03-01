drop table if exists area_raster;

create table area_raster as (
    select st_asraster(geom,${WIDTH}, ${HEIGHT}, ARRAY['32BF']) rast
    from area
);
