#!/bin/sh

echo "Test3"

if [[ $WERCKER_ADD_COMMIT_TAG_MESS=~ ([0-9]+\.[0-9]+)([^,]*) ]]; then echo "version: '${BASH_REMATCH[1]}'"; else echo "no match found"; fi

