#!/bin/bash

# shellcheck disable=SC1017
set -eo pipefail


if [ -z "$GIT_COMMIT_MESSAGE" ]; then
  echo "You must specify a message"
  exit
fi

if [ -z "$GIT_COMMIT" ]; then
  echo "You must specify a commit"
  exit
fi

if [ -z "$REPO_NAME" ]; then
  echo "You must specify a repository"
  exit
fi

# if [ -z "$GIT_TAG_COMMIT_BRANCH" ]; then
#   echo "You must specify a branch"
#   exit
# fi

if [ -z "$REPO_USER" ]; then
  echo "You must specify a user"
  exit
fi

if [ -z "$GIT_TOKEN" ]; then
  echo "You must provide token"
  exit
fi


TAG=$(echo $GIT_COMMIT_MESSAGE| grep -w -Eo "[0-9]+\.[0-9]+\.[0-9]+" | head -n1)

if [ -n "$TAG" ]; then
  GIT_URL="https://api.github.com/repos/${REPO_USER}/${REPO_NAME}/git/refs"

  echo -e "{\n}"| 
  jq 'setpath(["ref"]; "'"refs/tags/${TAG}"'")'|
  jq 'setpath(["sha"]; "'"${GIT_COMMIT}"'")' > create_tag.json

  #create tag
  RESPONSE_CODE=$(curl --write-out %{http_code} --silent --output /dev/null -X POST --data @create_tag.json  -H "Content-Type: application/json" -H "Authorization: token $GIT_TOKEN" $GIT_URL )
  if [[ $RESPONSE_CODE != 201 ]];then
            echo "Error creating tag $TAG, ERROR_CODE: $RESPONSE_CODE"
            exit 2
    fi
  else 
    echo "Tag ${TAG} has been created on commit ${GIT_COMMIT}"
fi
