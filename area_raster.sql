drop table if exists area_raster;

create table area_raster as (
    select st_asraster(geom,${WIDTH}, ${HEIGHT}, '32BF',1,-(pow(2,31)-1)) rast
    from area
);
