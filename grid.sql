drop table if exists grid;
create table grid as (

with extent as (select st_extent(geom) as geom from city)

select st_setsrid(
    st_makepoint(st_xmin(geom) + dx/1024.0*(st_xmax(geom) - st_xmin(geom)),
                 st_ymax(geom) + dy/1024.0*(st_ymin(geom) - st_ymax(geom))),
    4326) as geom
from extent,
generate_series(0,1023) dx,
generate_series(0,1023) dy

);

alter table grid add column distance decimal;
alter table grid add column id serial primary key;
create index on grid using GIST (geom);

-- set a flag for those points inside the city limits
alter table grid add column interior boolean default false;

with interior as (select g.id from grid g join city c on st_contains(c.geom, g.geom))
update grid g
SET interior = true
FROM interior i
where g.id = i.id;
