#!/bin/sh


#tracker-repo
# broadleaf-admin -api -site
# fulfilment-layer
# integration-layer
# magnolia-cms

# git repo
# broadleaf-commerce
# fulfilment-layer
# integration-layer
# magnolia-cms

#pushd $WERCKER_SOURCE_DIR
#WERCKER_GIT_COMMIT_MESSAGE=`git log -1 --pretty='%s'`
#echo Git commit message: $WERCKER_GIT_COMMIT_MESSAGE
#popd

if [ -z "$WERCKER_GIT_COMMIT_MESSAGE" ]; then
   fail "GIT_COMMIT_MESSAGE not set"
fi

TAG_MAGNOLIA=$(cat $WERCKER_SOURCE_DIR/versions/magnolia-cms.version)
TAG_BROADLEAF=$(cat $WERCKER_SOURCE_DIR/versions/broadleaf-admin.version)
TAG_FULFILMENT=$(cat $WERCKER_SOURCE_DIR/versions/fulfilment-layer.version)
TAG_INTENGRATION=$(cat $WERCKER_SOURCE_DIR/versions/INTEGRATION-layer.version)

REP_MAGNOLIA="magnolia-cms"
REP_BROADLEAF="broadleaf-commerce"
REP_FULFILMENT="fulfilment-layer"
REP_INTEGRATION="integration-layer"




