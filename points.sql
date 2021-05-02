drop table if exists points;

create table points as (
with tiles as (
    select st_tile(rast, 32, 32) rast
    from area_raster
)

SELECT val > 0 as land, geom FROM (SELECT (ST_PixelAsPoints(rast, 1, false)).* FROM tiles) t

);
