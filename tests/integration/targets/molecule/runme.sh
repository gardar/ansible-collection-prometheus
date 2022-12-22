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
ls /root/ansible/lib/ansible
ls /root
ls /root/ansible
ls /root/ansible/lib/ansible/executor

unset ANSIBLE_PYTHON_INTERPRETER
unset ANSIBLE_CONNECTION_PATH
unset ANSIBLE_LIBRARY
unset ANSIBLE_COLLECTIONS_PATH

ansible-config dump --only-changed | cat

molecule --debug test
