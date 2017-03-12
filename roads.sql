drop table if exists ${SCHEMA}.roads;

create table ${SCHEMA}.roads as (
select * 
from ${SCHEMA}.planet_osm_line
where highway in (
    'motorway', 'trunk', 'primary', 'secondary', 'tertiary', 'unclassified', 
    'residential', 'service', 'motorway_link', 'trunk_link', 'primary_link', 
    'secondary_link', 'motorway_junction')
or aeroway is not null
);

create index roads_index on ${SCHEMA}.roads using gist(way);
