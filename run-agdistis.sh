#!/bin/bash -x

### --- Ref ---
# https://github.com/AKSW/AGDISTIS/wiki/3-Running-the-webservice

mvn tomcat:run

wait 15

# index=indexdbpedia_en_2014
INDEX_DBPEDIA_DIR="./indexdbpedia_en_2014"

### --- Unzip DBpedia Index Directory ---
if [ ! -e ${INDEX_DBPEDIA_DIR} ]; then
    echo "---WARN: Can't find de-compressed index DBpedia directory"
    if [ -f ./data/indexdbpedia_en_2014.7z ]; then
        echo "---INFO: unzip index file: ${INDEX_DBPEDIA_DIR}"
echo "        7za -x ./data/indexdbpedia_en_2014.7z -o /tmp"
    else
        echo "---ERROR: Can't find the compressed index dbpedia: indexdbpedia_en_2014.7z"
        exit 1
    fi
else
    echo "---INFO: index dbpedia already existing: ${INDEX_DBPEDIA_DIR}"
fi

exit 0

### --- Test against AGDISTIS ---
curl --data-urlencode "text='The <entity>University of Leipzig</entity> in <entity>Barack Obama</entity>.'" -d type=agdistis http://127.0.0.1:8080/AGDISTIS


