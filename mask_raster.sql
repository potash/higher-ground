drop table if exists ${SCHEMA}.mask_raster;

create table ${SCHEMA}.mask_raster as (
    with mask as (
        select st_collect(way) geom
        from ${SCHEMA}.planet_osm_polygon
        where ${MASK_CONDITION}
    )
    select st_clip(st_asraster(geom,rast,'${PIXELTYPE}',1,${NODATA_VALUE}, true), st_envelope(rast)) rast
    from mask, ${SCHEMA}.area_raster
);
