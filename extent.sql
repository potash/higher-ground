drop table if exists extent;
create table extent as (

select ST_SetSRID(st_extent(geom), ${SRID}) as geom from land

);
