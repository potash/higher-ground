drop aggregate if exists array_agg_mult(anyarray);
CREATE AGGREGATE array_agg_mult (anyarray)  (
    SFUNC     = array_cat
   ,STYPE     = anyarray
   ,INITCOND  = '{}'
);

drop table if exists rast_distances;
create table rast_distances as (

with array1d as (
    select y, array_agg(
        CASE WHEN not interior THEN -2 WHEN interior THEN coalesce(distance,-1) END order by x) a
    from grid group by 1
),

array2d as (
    select array_agg_mult(array[a] order by y) as values
    from array1d group by True
)

select st_setvalues(rast, 1, 1, 1, values::double precision[][], 
        NULL::double precision) rast from array2d, rast

);
