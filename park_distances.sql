drop table if exists ${SCHEMA}.park_distances;

create table ${SCHEMA}.park_distances as (
    select geom,
        (select p.geom<->parks.way distance
         from ${SCHEMA}.parks
         order by p.geom<->parks.way asc limit 1)
    from ${SCHEMA}.points p                                    
    where land
);
