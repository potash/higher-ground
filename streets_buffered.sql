drop table if exists streets_buffered;

create table streets_buffered as (
    select st_boundary(st_union(st_buffer(geom, .0001))) as geom from streets
);
