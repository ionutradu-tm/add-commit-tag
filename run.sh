#!/bin/sh
set -e
set +o pipefail

patch=`echo $WERCKER_GIT_TAG_COMMIT_MESSAGE| grep -w -Eo "[0-9]+\.[0-9]+\.[0-9]+" | head -n1`
version=`echo $WERCKER_GIT_TAG_COMMIT_MESSAGE| grep -w -Eo "[0-9]+\.[0-9]+" | head -n1`

if [ -n "$patch" ]; then
   tag=$patch
   echo "Apply tag $tag to commit $commit"
else
   if [ -n "$version" ]; then
      tag=$version
      echo "Apply tag $tag to commit $commit"
   else
      echo "No version/patch found"
      exit
   fi
fi

git config --global user.email email@wercker.com
git config --global user.name wercker

rm -rf /tmp/$repository
mkdir -p /tmp/$repository
cd /tmp/$repository

git clone -b $branch git@github.com:$user/$repository.git .
git tag $tag $commit
git push origin --tags
rm -rf /tmp/$repository
