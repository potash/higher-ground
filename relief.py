import mapnik
import os
from osgeo import gdal

EPSG_3395 = '+proj=merc +lon_0=0 +k=1 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs'

f = gdal.Open(os.environ['INPUT2'])
m = mapnik.Map(f.RasterXSize, f.RasterYSize)
m.srs = EPSG_3395

m.background = mapnik.Color('steelblue')
mapnik.load_map(m, os.environ['INPUT1'])

def create_layer(ds, file, name, m, srs=EPSG_3395):
    layer = mapnik.Layer(name)
    layer.srs = EPSG_3395

    layer.datasource = ds(file=file)
    layer.styles.append(name)
    m.layers.append(layer)

create_layer(mapnik.Gdal, os.environ['INPUT2'], 'color', m)
create_layer(mapnik.Gdal, os.environ['INPUT3'], 'slope', m)
create_layer(mapnik.Gdal, os.environ['INPUT4'], 'hillshade', m)
create_layer(mapnik.Shapefile, os.environ['INPUT5'], 'water', m)
create_layer(mapnik.Gdal, os.environ['INPUT6'], 'mask', m)

m.zoom_to_box(m.layers[0].envelope())
mapnik.render_to_file(m, os.environ['OUTPUT'])
