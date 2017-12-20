FROM mdillon/postgis:9.6

RUN set -ex; apt-get update && \
    apt-get install -y gdal-bin && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir /rasters && \
    chown postgres:postgres -R /rasters;

COPY raster-import.sh /docker-entrypoint-initdb.d/
