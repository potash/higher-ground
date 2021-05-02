drop table if exists area_raster;

create table area_raster as (
    select st_asraster(geom,${SCALE}, -${SCALE}, '${PIXELTYPE}',1,${NODATA_VALUE}) rast
    from area
);
