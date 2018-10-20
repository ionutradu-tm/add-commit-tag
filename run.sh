#!/bin/sh

echo $WERCKER_GIT_TAG_COMMIT_MESSAGE

if [[ $WERCKER_GIT_TAG_COMMIT_MESSAGE =~ ([0-9]+\.[0-9]+)([^,]*) ]]; then echo "version: '${BASH_REMATCH[1]}'"; else echo "no match found"; fi
#if [[ $WERCKER_ADD_COMMIT_TAG_MESS=~ ([0-9]+\.[0-9]+)([^,]*) ]]; then echo "version: '${BASH_REMATCH[1]}'"; else echo "no match found"; fi
#if [[ $WERCKER_ADD_COMMIT_TAG_MESS=~ [0-9]+\.[0-9]+ ]]; then echo "version: '${BASH_REMATCH[1]}'"; else echo "no match found"; fi

