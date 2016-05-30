#!/bin/bash -x

<<<<<<< HEAD
### --- Vars ---
INDEX_DIR_BASE=/tmp

# index=indexdbpedia_en_2014
### --- URLs for INDEX files ---
INDEX_7Z_EN_URL="http://139.18.2.164/rusbeck/agdistis/en/indexdbpedia_en_2014.7z"
INDEX_7Z_DE_URL="http://139.18.2.164/rusbeck/agdistis/de/indexdbpedia_de_2014.7z"
INDEX_7Z_ZH_URL="http://139.18.2.164/rusbeck/agdistis/zh/indexdbpedia_zh_2014.7z"
#INDEX_7Z_LIST="$INDEX_7Z_EN_URL $INDEX_7Z_DE_URL $INDEX_7Z_ZH_URL"
INDEX_7Z_LIST="$INDEX_7Z_EN_URL"

function 7zip_decompress() {
    echo "            7za x ${1} -o${2}"
}

### --- Unzip DBpedia Index Directory ---
for i in ${INDEX_7Z_LIST}; do
echo "-----------------------------------"
    INDEX_7Z_FILE="$(basename $i)"
    INDEX_DBPEDIA_DIR="${INDEX_7Z_FILE%.*}"
    if [ ! -e ${INDEX_DIR_BASE}/${INDEX_DBPEDIA_DIR} ]; then
        echo "--- INFO: Need to download and de-compressed index DBpedia directory"
        #if [ -f ./data/indexdbpedia_en_2014.7z ]; then
        if [ ! -s ${INDEX_7Z_FILE} ]; then
            echo "--- INFO: Need to download INDEX file: $i "
            wget $i
        fi
        echo "--- INFO: unzip index file: ${INDEX_7Z_FILE}"
        #7za x indexdbpedia_en_2014.7z -o/tmp
        7za x ${INDEX_7Z_FILE} -o${INDEX_DIR_BASE}
    else
        echo "--- INFO: index dbpedia already existing: ${INDEX_DIR_BASE}/${INDEX_DBPEDIA_DIR}"
    fi
done

echo "mvn tomcat:run | tee run.log "
=======
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

>>>>>>> f48dc979e1d1c4450cf525e6d3b9ec09600fcdde

