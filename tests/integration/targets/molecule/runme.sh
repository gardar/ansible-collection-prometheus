#!/usr/bin/env bash

set -eux

echo "$@"


apt -y update
apt -y install docker.io
python -m pip install molecule molecule-docker
cd ../../../../../../../../../roles/node_exporter
ansible --version
#ansible-doc --list -j
#ls /root/ansible/lib/ansible
#ls /root
#ls /root/ansible
#ls /root/ansible/lib/ansible/executor

unset _ANSIBLE_COVERAGE_CONFIG
unset ANSIBLE_PYTHON_INTERPRETER
#unset ANSIBLE_CONNECTION_PATH
#unset ANSIBLE_LIBRARY
#unset ANSIBLE_COLLECTIONS_PATH
#unset ANSIBLE_PLAYBOOK_DIR
#unset ANSIBLE_PYTHON_MODULE_RLIMIT_NOFILE
#env

ansible-config dump --only-changed | cat

molecule test
