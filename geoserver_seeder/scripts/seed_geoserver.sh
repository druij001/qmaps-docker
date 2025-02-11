#!/bin/bash

host=geoserver

echo "fetching cached layers ------------------------"
initial_string=$(curl -X GET http://$host:8080/geoserver/gwc/rest/layers -H  "accept: application/json" -H  "content-type: application/json")

duration=60
counter=0

# Loop until the duration is reached OR my_string is not empty
while [ $counter -lt $duration ]; do
initial_string=$(curl -X GET http://$host:8080/geoserver/gwc/rest/layers -H  "accept: application/json" -H  "content-type: application/json")
  # Check if my_string is NOT empty
  if [ ! -z "$initial_string" ]; then  # -z checks for empty, ! inverts the test
    echo ">>>>>>>>>>>>>>>>>>>>>>> String is not empty!"
    break  # Exit the loop
  fi

  echo "String empty"
  sleep 1
done

# 1. Remove the square brackets:
temp="${initial_string#[*}"  # Remove leading [
temp="${temp%]}"     # Remove trailing ]
temp=$(echo $temp | tr ',' ' ');
temp=$(echo $temp | tr '"' ' ');

LAYERS=($temp)

echo ">"
echo "LAYERS = ${LAYERS[@]}"
echo "modifying layers --------------------------"

# Loop through the array and print each layer name
layer="qmaps:aus_roads_with_vertices"
zoomStart=3
zoomStop=10
echo http://$host:8080/geoserver/gwc/rest/layers/$layer
curl -X PUT http://$host:8080/geoserver/gwc/rest/layers/$layer -H  "accept: application/json" -H  "content-type: application/xml" -d "<GeoServerLayer>    <enabled>true</enabled>        <name>$layer</name>        <mimeFormats>            <string>image/png</string>        </mimeFormats>    <gridSubsets><gridSubset> <gridSetName>EPSG:4326</gridSetName> <extent>   <coords>     <double>$x1</double>     <double>$y2</double>     <double>$x2</double>     <double>$y1</double>   </coords> </extent>    <zoomStart>$zoomStart</zoomStart>    <zoomStop>$zoomStop</zoomStop>    <minCachedLevel>$zoomStart</minCachedLevel>    <maxCachedLevel>$zoomStop</maxCachedLevel></gridSubset></gridSubsets><metaWidthHeight>    <int>4</int>    <int>4</int>  </metaWidthHeight><autoCacheStyles>true</autoCacheStyles></GeoServerLayer>"
curl -XPOST -H "Content-type: text/xml" -d "<seedRequest><name>$layer</name><srs><number>4326</number></srs><zoomStart>$zoomStart</zoomStart><zoomStop>$zoomStop</zoomStop><format>image/png</format><type>seed</type><threadCount>10</threadCount></seedRequest>"  "http://$host:8080/geoserver/gwc/rest/seed/$layer.xml"

layer="qmaps:planet_osm_line"
zoomStart=10
zoomStop=17
echo http://$host:8080/geoserver/gwc/rest/layers/$layer
curl -X PUT http://$host:8080/geoserver/gwc/rest/layers/$layer -H  "accept: application/json" -H  "content-type: application/xml" -d "<GeoServerLayer>    <enabled>true</enabled>        <name>$layer</name>        <mimeFormats>            <string>image/png</string>        </mimeFormats>    <gridSubsets><gridSubset> <gridSetName>EPSG:4326</gridSetName> <extent>   <coords>     <double>$x1</double>     <double>$y2</double>     <double>$x2</double>     <double>$y1</double>   </coords> </extent>    <zoomStart>$zoomStart</zoomStart>    <zoomStop>$zoomStop</zoomStop>    <minCachedLevel>$zoomStart</minCachedLevel>    <maxCachedLevel>$zoomStop</maxCachedLevel></gridSubset></gridSubsets><metaWidthHeight>    <int>4</int>    <int>4</int>  </metaWidthHeight><autoCacheStyles>true</autoCacheStyles></GeoServerLayer>"
curl -XPOST -H "Content-type: text/xml" -d "<seedRequest><name>$layer</name><srs><number>4326</number></srs><zoomStart>$zoomStart</zoomStart><zoomStop>$zoomStop</zoomStop><format>image/png</format><type>seed</type><threadCount>10</threadCount></seedRequest>"  "http://$host:8080/geoserver/gwc/rest/seed/$layer.xml"

layer="qmaps:aus_amenities"
zoomStart=15
zoomStop=18
echo http://$host:8080/geoserver/gwc/rest/layers/$layer
curl -X PUT http://$host:8080/geoserver/gwc/rest/layers/$layer -H  "accept: application/json" -H  "content-type: application/xml" -d "<GeoServerLayer>    <enabled>true</enabled>        <name>$layer</name>        <mimeFormats>            <string>image/png</string>        </mimeFormats>    <gridSubsets><gridSubset> <gridSetName>EPSG:4326</gridSetName> <extent>   <coords>     <double>$x1</double>     <double>$y2</double>     <double>$x2</double>     <double>$y1</double>   </coords> </extent>    <zoomStart>$zoomStart</zoomStart>    <zoomStop>$zoomStop</zoomStop>    <minCachedLevel>$zoomStart</minCachedLevel>    <maxCachedLevel>$zoomStop</maxCachedLevel></gridSubset></gridSubsets><metaWidthHeight>    <int>4</int>    <int>4</int>  </metaWidthHeight><autoCacheStyles>true</autoCacheStyles></GeoServerLayer>"
curl -XPOST -H "Content-type: text/xml" -d "<seedRequest><name>$layer</name><srs><number>4326</number></srs><zoomStart>$zoomStart</zoomStart><zoomStop>$zoomStop</zoomStop><format>image/png</format><type>seed</type><threadCount>10</threadCount></seedRequest>"  "http://$host:8080/geoserver/gwc/rest/seed/$layer.xml"

layer="qmaps:planet_osm_polygon"
zoomStart=15
zoomStop=18
echo http://$host:8080/geoserver/gwc/rest/layers/$layer
curl -X PUT http://$host:8080/geoserver/gwc/rest/layers/$layer -H  "accept: application/json" -H  "content-type: application/xml" -d "<GeoServerLayer>    <enabled>true</enabled>        <name>$layer</name>        <mimeFormats>            <string>image/png</string>        </mimeFormats>    <gridSubsets><gridSubset> <gridSetName>EPSG:4326</gridSetName> <extent>   <coords>     <double>$x1</double>     <double>$y2</double>     <double>$x2</double>     <double>$y1</double>   </coords> </extent>    <zoomStart>$zoomStart</zoomStart>    <zoomStop>$zoomStop</zoomStop>    <minCachedLevel>$zoomStart</minCachedLevel>    <maxCachedLevel>$zoomStop</maxCachedLevel></gridSubset></gridSubsets><metaWidthHeight>    <int>4</int>    <int>4</int>  </metaWidthHeight><autoCacheStyles>true</autoCacheStyles></GeoServerLayer>"
curl -XPOST -H "Content-type: text/xml" -d "<seedRequest><name>$layer</name><srs><number>4326</number></srs><zoomStart>$zoomStart</zoomStart><zoomStop>$zoomStop</zoomStop><format>image/png</format><type>seed</type><threadCount>10</threadCount></seedRequest>"  "http://$host:8080/geoserver/gwc/rest/seed/$layer.xml"


layer="qmaps:ESRIWI_AUS"
zoomStart=0
zoomStop=5
echo http://$host:8080/geoserver/gwc/rest/layers/$layer
curl -X PUT http://$host:8080/geoserver/gwc/rest/layers/$layer -H  "accept: application/json" -H  "content-type: application/xml" -d "<GeoServerLayer>    <enabled>true</enabled>        <name>$layer</name>        <mimeFormats>            <string>image/png</string>        </mimeFormats>    <gridSubsets><gridSubset> <gridSetName>EPSG:4326</gridSetName> <extent>   <coords>     <double>$x1</double>     <double>$y2</double>     <double>$x2</double>     <double>$y1</double>   </coords> </extent>    <zoomStart>$zoomStart</zoomStart>    <zoomStop>$zoomStop</zoomStop>    <minCachedLevel>$zoomStart</minCachedLevel>    <maxCachedLevel>$zoomStop</maxCachedLevel></gridSubset></gridSubsets><metaWidthHeight>    <int>4</int>    <int>4</int>  </metaWidthHeight><autoCacheStyles>true</autoCacheStyles></GeoServerLayer>"
curl -XPOST -H "Content-type: text/xml" -d "<seedRequest><name>$layer</name><srs><number>4326</number></srs><zoomStart>$zoomStart</zoomStart><zoomStop>$zoomStop</zoomStop><format>image/png</format><type>seed</type><threadCount>10</threadCount></seedRequest>"  "http://$host:8080/geoserver/gwc/rest/seed/$layer.xml"