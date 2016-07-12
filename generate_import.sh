#!/bin/bash
shp2pgsql -I -d -s 4326 $1 streets
