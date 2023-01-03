#!/usr/bin/env bash

collection_root=$(pwd | grep -oP ".+\/ansible_collections\/\w+?\/\w+")
targetname=${PWD##*/}
targetarray=(${targetname//-/ })
role=(${targetarray[0]})
scenario=(${targetarray[2]})

apt -y update
apt -y install docker.io
python -m pip install molecule molecule-docker

cd $collection_root/roles/$role
unset _ANSIBLE_COVERAGE_CONFIG
unset ANSIBLE_PYTHON_INTERPRETER

molecule test -s $scenario

#if [ "${targetarray[1]}" = "molecule" ]; then
#  role=(${targetarray[0]})
#  scenario=(${targetarray[2]})
#  echo ${role}
#  echo ${scenario}
#  $collection_root/tests/integration/targets/_molecule/molecule.sh ${role} ${scenario}
#else
#  echo "ERROR: Unable to recognize molecule test target"
#  echo "Got: $targetname"
#  echo "But directory should be named '<rolename>-molecule-<scenarioname>'"
#  exit 126
#fi
