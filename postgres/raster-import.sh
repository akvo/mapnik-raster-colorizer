#!/usr/bin/env bash

set -eu

GEOTIFF="SLE10adjv4.tif"
ARCHIVE="/rasters/SLE.tar.gz"
DB_NAME="sierra_leone"

if [[ ! -f "${ARCHIVE}" ]]; then
    exit 1;
fi

echo "CREATE DATABASE ${DB_NAME} TEMPLATE template_postgis" | psql -U postgres -h localhost

cd /tmp

tar xvfz "${ARCHIVE}"

# Import - No transformation

raster2pgsql -C -I -Y "${GEOTIFF}" -t 128x128 sle_pop | psql -U postgres -h localhost -d "${DB_NAME}"

# Reproject and compress

gdalwarp -ot Byte -co COMPRESS=LZW -t_srs EPSG:3857 "${GEOTIFF}" "sle-wm.tif"

raster2pgsql -C -I -Y "sle-wm.tif" -t 128x128 sle_pop_wm | psql -U postgres -h localhost -d "${DB_NAME}"
