#!/bin/sh

set -eo pipefail


if [ -z "$WERCKER_GIT_TAG_COMMIT_MESSAGE" ]; then
  echo "You must specify a message"
  exit
fi

if [ -z "$WERCKER_GIT_TAG_COMMIT_COMMIT" ]; then
  echo "You must specify a commit"
  exit
fi

if [ -z "$WERCKER_GIT_TAG_COMMIT_REPOSITORY" ]; then
  echo "You must specify a repository"
  exit
fi

if [ -z "$WERCKER_GIT_TAG_COMMIT_BRANCH" ]; then
  echo "You must specify a branch"
  exit
fi

if [ -z "$WERCKER_GIT_TAG_COMMIT_USER" ]; then
  echo "You must specify a user"
  exit
fi


patch=`echo $WERCKER_GIT_TAG_COMMIT_MESSAGE| grep -w -Eo "[0-9]+\.[0-9]+\.[0-9]+" | head -n1`
version=`echo $WERCKER_GIT_TAG_COMMIT_MESSAGE| grep -w -Eo "[0-9]+\.[0-9]+" | head -n1`

if [ -n "$patch" ]; then
   tag=$patch
   echo "Apply tag $tag to commit $WERCKER_GIT_TAG_COMMIT_COMMIT"
else
   if [ -n "$version" ]; then
      tag=$version
      echo "Apply tag $tag to commit $WERCKER_GIT_TAG_COMMIT_COMMIT"
   else
      echo "No version/patch found"
   fi
fi

if [ -n "$tag" ]; then
  git config --global user.email email@wercker.com
  git config --global user.name wercker

  rm -rf /tmp/$WERCKER_GIT_TAG_COMMIT_REPOSITORY
  mkdir -p /tmp/$WERCKER_GIT_TAG_COMMIT_REPOSITORY
  cd /tmp/$WERCKER_GIT_TAG_COMMIT_REPOSITORY

  git clone -b $WERCKER_GIT_TAG_COMMIT_BRANCH git@github.com:$WERCKER_GIT_TAG_COMMIT_USER/$WERCKER_GIT_TAG_COMMIT_REPOSITORY.git .
  git tag $tag $WERCKER_GIT_TAG_COMMIT_COMMIT
  git push origin --tags
  rm -rf /tmp/$WERCKER_GIT_TAG_COMMIT_REPOSITORY
fi
