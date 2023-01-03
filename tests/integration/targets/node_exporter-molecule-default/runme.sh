#!/usr/bin/env bash

ls ../
pwd
collection_root=$(pwd | grep -oP ".+\/ansible_collections\/\w+?\/\w+")
targetname=${PWD##*/}
targetarray=(${targetname//-/ })
if [ "${targetarray[1]}" = "molecule" ]; then
  role=(${targetarray[0]})
  scenario=(${targetarray[2]})
  echo ${role}
  echo ${scenario}
  $collection_root/tests/_molecule/molecule.sh ${role} ${scenario}
else
  echo "ERROR: Unable to recognize molecule test target"
  echo "Got: $targetname"
  echo "But directory should be named '<rolename>-molecule-<scenarioname>'"
  exit 126
fi
