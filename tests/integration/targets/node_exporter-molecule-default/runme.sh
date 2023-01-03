#!/usr/bin/env bash

targetname=${PWD##*/}
targetarray=(${targetname//-/ })
if [ "${targetarray[1]}" = "molecule" ]; then
  role=(${targetarray[0]})
  scenario=(${targetarray[2]})
  echo ${role}
  echo ${scenario}
  ../molecule/molecule.sh ${role} ${scenario}
else
  echo "ERROR: Unable to recognize molecule test target"
  echo "Got: $targetname"
  echo "But directory should be named '<rolename>-molecule-<scenarioname>'"
  exit 126
fi
