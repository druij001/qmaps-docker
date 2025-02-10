#!/bin/bash

bash --version
echo "_______________________________________________________________"

echo "The value of MY_VARIABLE is: $MY_VARIABLE"
echo $x1

# x1=115.07390026940892
# y1=-43.79159844705773
# x2=165.4564299240678
# y2=-12.664860648327975

host=geoserver


echo "fetching cached layers ------------------------"
initial_string=$(curl -X GET http://$host:8080/geoserver/gwc/rest/layers -H  "accept: application/json" -H  "content-type: application/json")
#initial_string='["qmaps:planet_osm_line","qmaps:ESRIWI_AUS","qmaps:aus_roads_with_vertices","qmaps:planet_osm_polygon","qmaps:aus_amenities"]'

# 1. Remove the square brackets:
temp="${initial_string#[*}"  # Remove leading [
temp="${temp%]}"     # Remove trailing ]

# 2. Replace commas with spaces (and handle quotes):
# 2. Use `tr` to replace commas with spaces:
temp=$(echo $temp | tr ',' ' ');
temp=$(echo $temp | tr '"' ' ');


# 3. Create the array:
LAYERS=($temp)

echo ">"

echo "LAYERS = ${LAYERS[@]}"

echo ">"
echo "modifying aus_roads --------------------------"
# Loop through the array and print each layer name
for l in "${LAYERS[@]}"; do  # Corrected loop  

    curl -X PUT http://$host:8080/geoserver/gwc/rest/layers/$l -H  "accept: application/json" -H  "content-type: application/xml" -d "<GeoServerLayer>    <enabled>true</enabled>        <name>$l</name>        <mimeFormats>            <string>image/png</string>        </mimeFormats>    <gridSubsets><gridSubset> <gridSetName>EPSG:4326</gridSetName> <extent>   <coords>     <double>$x1</double>     <double>$y1</double>     <double>$x2</double>     <double>$y2</double>   </coords> </extent>    <zoomStart>5</zoomStart>    <zoomStop>20</zoomStop>    <minCachedLevel>1</minCachedLevel>    <maxCachedLevel>21</maxCachedLevel></gridSubset></gridSubsets><metaWidthHeight>    <int>4</int>    <int>4</int>  </metaWidthHeight><autoCacheStyles>true</autoCacheStyles></GeoServerLayer>"
    echo " "
    echo "LAYER UPDATED: $l"

done