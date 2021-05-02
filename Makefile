DOWNLOAD_DIR=/home/eric/docs/www/osm/
PBF_URL="http://download.geofabrik.de/north-america/us/new-york-latest.osm.pbf"
PBF_FILENAME=$(DOWNLOAD_DIR)/$(shell basename $(PBF_URL))

NODATA_VALUE=-2147483648
SCALE=100.0
PIXELTYPE=32BF
export NODATA_VALUE SCALE PIXELTYPE
PGDATABASE=higher_ground
SRID=32618 # UTM zone 18N
export PGDATABASE
psql="psql -d higher_ground -v ON_ERROR_STOP=1"

# Download PBF file
$(PBF_FILENAME):
	mkdir -p $(dirname $@)
	curl "$(PBF_URL)" > $@

# Create extract schema
#psql/extract:
#	psql -v ON_ERROR_STOP=1 -c "CREATE SCHEMA IF NOT EXISTS extract" && mkdir -p $@

$(shell mkdir -p psql)

# Load PBF file into postgres
psql/extract: $(PBF_FILENAME)
	# bounding box from https://apa.ny.gov/gis/GisData/Boundaries/apalandclass.html
	osm2pgsql --slim --drop --proj $(SRID) --create --database $(PGDATABASE) --bbox -75.5,43,-73,45 $<
	touch $@

# $(call execute_sql,script.sql,outfile)
define execute_sql
    cat $(1) | envsubst
    cat $(1) | envsubst | psql -v ON_ERROR_STOP=1 -d $(PGDATABASE) 2>&1 && echo > $(2)
endef

LAND_CONDITION=name = 'Adirondack Park'
export LAND_CONDITION
psql/area: area.sql psql/extract
	$(call execute_sql,$<,$@)

psql/water: water.sql psql/extract psql/area
	$(call execute_sql,$<,$@)

psql/parks: parks.sql psql/extract psql/area
	$(call execute_sql,$<,$@)

psql/roads: roads.sql psql/extract
	$(call execute_sql,$<,$@)

psql/area_raster: area_raster.sql psql/area
	$(call execute_sql,$<,$@)

psql/points: points.sql psql/area_raster
	$(call execute_sql,$<,$@)

psql/distances: distances.sql psql/points psql/roads
	$(call execute_sql,$<,$@)

psql/distances_raster: distances_raster.sql psql/points psql/distances
	$(call execute_sql,$<,$@)

psql/max_distances: max_distances.sql psql/parks psql/distances
	$(call execute_sql,$<,$@)
