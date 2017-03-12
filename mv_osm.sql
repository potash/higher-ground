drop table if exists ${SCHEMA}.planet_osm_nodes;
alter table planet_osm_nodes set schema ${SCHEMA};

drop table if exists ${SCHEMA}.planet_osm_rels;
alter table planet_osm_rels set schema ${SCHEMA};

drop table if exists ${SCHEMA}.planet_osm_ways;
alter table planet_osm_ways set schema ${SCHEMA};

drop table if exists ${SCHEMA}.planet_osm_polygon;
alter table planet_osm_polygon set schema ${SCHEMA};

drop table if exists ${SCHEMA}.planet_osm_point;
alter table planet_osm_point set schema ${SCHEMA};

drop table if exists ${SCHEMA}.planet_osm_line;
alter table planet_osm_line set schema ${SCHEMA};

drop table if exists ${SCHEMA}.planet_osm_roads;
alter table planet_osm_roads set schema ${SCHEMA};
