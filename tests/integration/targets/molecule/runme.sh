#!/usr/bin/env bash

set -eux

echo "$@"
ls -1
pwd
ls ../
ls ../../
ls ../../../
ls ../../../../
ls ../../../../../
ls ../../../../../../
ls ../../../../../../../
ls ../../../../../../../../
ls ../../../../../../../../../
ls ../../../../../../../../../../
ls ../../../../../../../../../../../
ls ../../../../../../../../../../../../


apt -y update
apt -y install docker.io
pip install molecule molecule-docker
cd ../../../../../../../../../roles/node_exporter
ansible --version
ansible-doc --list -j
#ansible-config dump | cat
ls /
ls /set
ls /set/ansible_python_interpreter/
ls /set/ansible_python_interpreter/in/
ls /set/ansible_python_interpreter/in/inventory
#molecule test
