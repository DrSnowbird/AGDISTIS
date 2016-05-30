#!/bin/bash -x

### --- Test against AGDISTIS ---
curl --data-urlencode "text='The <entity>University of Leipzig</entity> in <entity>Barack Obama</entity>.'" -d type=agdistis http://127.0.0.1:8080/AGDISTIS

