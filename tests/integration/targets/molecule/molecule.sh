#!/usr/bin/env bash

set -eux

echo "$@"

role=$1
scenario=$2

apt -y update
apt -y install docker.io
python -m pip install molecule molecule-docker
collection_root=$(pwd | grep -oP ".+\/ansible_collections\/\w+?\/\w+")

cd $collection_root/roles/$role
ansible --version

unset _ANSIBLE_COVERAGE_CONFIG
unset ANSIBLE_PYTHON_INTERPRETER

ansible-config dump --only-changed | cat

molecule test -s $scenario
