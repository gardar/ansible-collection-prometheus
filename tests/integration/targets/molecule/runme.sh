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
#ansible-doc --list -j
#ansible-config dump | cat
ls /root/ansible/lib/ansible
ls /root
ls /root/ansible
ls /root/ansible/lib/ansible/executor

#ANSIBLE_PYTHON_INTERPRETER=auto molecule test
