drop aggregate if exists array_agg_mult(anyarray);
CREATE AGGREGATE array_agg_mult (anyarray)  (
    SFUNC     = array_cat
   ,STYPE     = anyarray
   ,INITCOND  = '{}'
);

drop table if exists park_distances_raster;
create table park_distances_raster as (

with distances as (
    select geom,distance from park_distances
    UNION ALL
    select geom,-1
    from points where not land
),

array1d as (
    select st_y(geom) y, array_agg(distance order by st_x(geom) asc) a
    from distances
   
    group by 1
),

array2d as (
    select array_agg_mult(array[a] order by y desc) as values
    from array1d group by True
)

select st_setvalues(rast, 1, 1, 1, values::double precision[][]) rast 
from array2d, area_raster

);
