from drain import util
import pandas as pd

def count_missing(engine):
    return pd.read_sql('select count(*) from grid where distance is null', engine).values[0][0]

def insert_missing(max_distance, engine):
    util.execute_sql("""with distances as (
        select distinct on (id) id,
            st_distance(g.geom, s.way) distance
        from grid g
            left join planet_osm_roads s on st_dwithin(g.geom, s.way, %s)
        where
            interior and 
            g.distance is null
        order by id, st_distance(g.geom, s.way)
    )

    UPDATE grid g
    SET distance = d.distance
    FROM distances d
    WHERE g.id =d.id and d.distance is not null;""" % max_distance, engine)

engine = util.create_engine()
for i in range(-3,1):
    print i
    insert_missing(10**i, engine)
