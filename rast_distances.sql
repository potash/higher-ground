drop aggregate if exists array_agg_mult(anyarray);
CREATE AGGREGATE array_agg_mult (anyarray)  (
    SFUNC     = array_cat
   ,STYPE     = anyarray
   ,INITCOND  = '{}'
);

drop table if exists rast_distances;
create table rast_distances as (

with array1d as (
    select st_y(geom) y, 
        array_agg(distance order by st_x(geom)) a
    from grid group by 1
),

array2d as (
    select array_agg_mult(array[a] order by y desc) as values
    from array1d group by True
)

select st_setvalues(rast, 1, 1, 1, values::double precision[][], 
        NULL::double precision) from array2d, rast

);
