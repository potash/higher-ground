drop table if exists rast;
create table rast as (

select 1 as rid,
    st_addband(st_MakeEmptyRaster(
        ${WIDTH},${HEIGHT},
        st_xmin(geom), st_ymax(geom),
        (st_xmax(geom) - st_xmin(geom))/${WIDTH},
        (st_ymin(geom) - st_ymax(geom))/${HEIGHT},
        0,0,${SRID}), 
        ARRAY[
            -- distance raster band 32 bit float
            ROW(1, '32BF'::text, -1, -1) 
        ]::addbandarg[]
    ) as rast
from extent
);
