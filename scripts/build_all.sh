#!/bin/sh
set -eu

$(dirname $0)/build_wikifarm.sh master 8080
$(dirname $0)/build_wikifarm.sh 1.31 8081
$(dirname $0)/build_wikifarm.sh 1.32 8082
$(dirname $0)/build_wikifarm.sh 1.33 8083
$(dirname $0)/build_wikifarm.sh 1.34 8084
