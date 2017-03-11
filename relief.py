import mapnik
import os
from osgeo import gdal

f = gdal.Open('output/diff_distances_hillshade.tiff')
map = mapnik.Map(f.RasterXSize, f.RasterYSize)
map.background = mapnik.Color('steelblue')
mapnik.load_map(map, 'relief.xml')
map.zoom_to_box(map.layers[0].envelope())
mapnik.render_to_file(map, 'output/relief.png')
