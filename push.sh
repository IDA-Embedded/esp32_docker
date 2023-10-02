#!/bin/bash
GIT_MSG=$1
if [ $# -eq 0 ]
  then
    echo "No arguments supplied"
    exit -1
fi

set -e # exit on error


git add .
git commit -m "$GIT_MSG"
git push

#sh ./tools/jenkins/callJenkins.sh
