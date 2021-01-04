#!/bin/bash

HUGO=$(which hugo)
if [ "${HUGO}" = "" ]; then
    echo "hugo was not found"
    exit 1
fi

REPO_BASE="$(dirname $(dirname $(readlink -f $0)))"
PUBLIC="${REPO_BASE}/public"

pushd ${REPO_BASE}

rm -rf ${PUBLIC}
hugo && rsync -auv --delete ${PUBLIC}/ alanliddell.com:public_html/

popd
