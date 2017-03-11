drop table if exists mask_raster;

create table mask_raster as (
    with mask as (
        select st_collect(way) geom from planet_osm_polygon
        where ${MASK_CONDITION}
    )
    select st_clip(st_asraster(geom,rast,'${PIXELTYPE}',1,${NODATA_VALUE}, true), st_envelope(rast)) rast
    from mask, area_raster
);
