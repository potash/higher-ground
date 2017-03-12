drop table if exists ${SCHEMA}.area_raster;

create table ${SCHEMA}.area_raster as (
    select st_asraster(geom,${SCALE}, -${SCALE}, '${PIXELTYPE}',1,${NODATA_VALUE}) rast
    from ${SCHEMA}.area
);
