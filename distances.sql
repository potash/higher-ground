drop table if exists ${SCHEMA}.distances;

create table ${SCHEMA}.distances as (
    select geom,
        (select p.geom<->r.way distance
         from ${SCHEMA}.roads r
         order by p.geom<->r.way asc limit 1)
    from ${SCHEMA}.points p
    where land
);
