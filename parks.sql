drop table if exists parks;

create table parks as (
    select planet_osm_polygon.*
    from planet_osm_polygon, area
    where st_intersects(way, area.geom) and (
        leisure in ('park','nature_preserve', 'nature_reserve') or
        landuse in ('conservation', 'forest') or
        ("natural" is not null and "natural" != 'water')
    )
);

create index parks_index on parks using gist (way);
