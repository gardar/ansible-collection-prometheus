#!/usr/bin/env bash

collection_root=$(pwd | grep -oP ".+\/ansible_collections\/\w+?\/\w+")
targetname=${PWD##*/}
role=$(expr "$targetname" : '\w*-\(\w*\)-\w*')
role_root="$collection_root/roles/$role"
scenario=$(expr "$targetname" : '\w*-\w*-\(\w*\)')

# Install requirements
apt -y update
apt -y install docker.io
if [ -f "$role_root/test-requirements.txt"  ]; then
	python -m pip install -r "$role_root/test-requirements.txt"
fi
if [ -f "$collection_root/test-requirements.txt"  ]; then
	python -m pip install -r "$collection_root/test-requirements.txt"
fi
python -m pip install molecule molecule-docker

export MOLECULE_FILE=$collection_root/.config/molecule/config.yml

# Unset ansible-test variables that break molecule
unset _ANSIBLE_COVERAGE_CONFIG
unset ANSIBLE_PYTHON_INTERPRETER

# Run molecule test
cd "$role_root"
molecule -c "$collection_root/.config/molecule/config.yml" test -s "$scenario"
