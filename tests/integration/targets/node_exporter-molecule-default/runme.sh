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
export MOLECULE_FILE=$collection_root/.config/molecule/config.yml

# Unset ansible-test variables that break molecule
unset _ANSIBLE_COVERAGE_CONFIG
unset ANSIBLE_PYTHON_INTERPRETER

molecule test -s $scenario
