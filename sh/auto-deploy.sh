#!/usr/bin/env bash

TAG=`git describe --tags`

if [ "$TAG" == "fatal: No names found, cannot describe anything." ] ; then
  echo $TAG;
  exit 0;
fi