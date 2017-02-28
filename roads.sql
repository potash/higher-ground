drop table if exists roads;

create table roads as (
select * from planet_osm_line
where highway in (
    'motorway', 'trunk', 'primary', 'secondary', 'tertiary', 'unclassified', 
    'residential', 'service', 'motorway_link', 'trunk_link', 'primary_link', 
    'secondary_link', 'motorway_junction')
);

create index roads_index on roads using gist(way);
