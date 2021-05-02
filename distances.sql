drop table if exists distances;

create table distances as (
    select geom,
        (select p.geom<->r.way distance
         from roads r
         order by p.geom<->r.way asc limit 1)
    from points p
    where land
);
