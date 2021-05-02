drop table if exists park_distances;

create table park_distances as (
    select geom,
        (select p.geom<->parks.way distance
         from parks
         order by p.geom<->parks.way asc limit 1)
    from points p                                    
    where land
);
