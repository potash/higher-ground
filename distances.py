from drain import util
import pandas as pd

def count_missing(engine):
    return pd.read_sql('select count(*) from grid where distance is null and interior', engine).values[0][0]

def clear_distances(engine):
    util.execute_sql("update grid set distance = null;", engine)

def insert_missing(max_distance, engine):
    util.execute_sql("""with distances as (
        select distinct on (id) id,
            st_distance(g.geom, r.way) distance
        from grid g
            left join roads r on st_dwithin(g.geom, r.way, %s)
        where
            interior and 
            g.distance is null
        order by id, st_distance(g.geom, r.way)
    )

    UPDATE grid g
    SET distance = d.distance
    FROM distances d
    WHERE g.id = d.id and d.distance is not null;""" % max_distance, engine)

engine = util.create_engine()
clear_distances(engine)
for i in range(1,4):
    missing = count_missing(engine)
    print missing
    if missing > 0:
        insert_missing(10**i, engine)
    else:
        break
