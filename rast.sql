drop table if exists rast;
create table rast as (

with extent as (select st_extent(geom) as geom from city)

select 1 as rid,
    st_addband(st_MakeEmptyRaster(
        1024,1024,
--      st_x(st_centroid(geom)), st_y(st_centroid(geom)),
        st_xmin(geom), st_ymax(geom),
        (st_xmax(geom) - st_xmin(geom))/1024,
        (st_ymin(geom) - st_ymax(geom))/1024,
        0,0,4326), 
        ARRAY[
            -- distance raster band 32 bit float
            ROW(1, '32BF'::text, -1, -1) 
        ]::addbandarg[]
    ) as rast
from extent
);
