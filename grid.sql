drop table if exists grid;
create table grid as (

select x, y, st_setsrid(
    st_makepoint(st_xmin(geom) + x*1.0/${WIDTH}*(st_xmax(geom) - st_xmin(geom)),
                 st_ymax(geom) + y*1.0/${HEIGHT}*(st_ymin(geom) - st_ymax(geom))),
    ${SRID}) as geom,
    null::decimal as distance,
    False as interior
from extent,
generate_series(0,${WIDTH}-1) x,
generate_series(0,${HEIGHT}-1) y

);

alter table grid add column id serial primary key;
create index on grid using GIST (geom);

-- set a flag for those points inside the city limits
with interior as (select g.id from grid g join land on st_contains(land.geom, g.geom))
update grid g
SET interior = true
FROM interior i
where g.id = i.id;
