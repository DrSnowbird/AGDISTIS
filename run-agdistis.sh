#!/bin/bash -x

### --- Ref ---
# https://github.com/AKSW/AGDISTIS/wiki/3-Running-the-webservice

### --- Vars ---
INDEX_DIR_BASE=/tmp
#INDEX_DIR_BASE=.

# index=indexdbpedia_en_2014
### --- URLs for INDEX files ---
INDEX_7Z_EN_URL="http://139.18.2.164/rusbeck/agdistis/en/indexdbpedia_en_2014.7z"
INDEX_7Z_DE_URL="http://139.18.2.164/rusbeck/agdistis/de/indexdbpedia_de_2014.7z"
INDEX_7Z_ZH_URL="http://139.18.2.164/rusbeck/agdistis/zh/indexdbpedia_zh_2014.7z"

### --- Change your language choice below accordingly ---
#INDEX_7Z_LIST="$INDEX_7Z_EN_URL $INDEX_7Z_DE_URL $INDEX_7Z_ZH_URL"
INDEX_7Z_LIST="$INDEX_7Z_EN_URL"

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
        ## -- Default properties setup for indexdbpedia_en_2014 directory is "./"
        ln -s ${INDEX_DIR_BASE}/${INDEX_DBPEDIA_DIR} ${INDEX_DBPEDIA_DIR}
    else
        echo "--- INFO: index dbpedia already existing: ${INDEX_DIR_BASE}/${INDEX_DBPEDIA_DIR}"
    fi
done

echo "mvn tomcat:run | tee run.log "

mvn tomcat:run



