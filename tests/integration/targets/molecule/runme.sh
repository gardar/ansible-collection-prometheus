#!/usr/bin/env bash

set -eux

echo "$@"

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_20.04/Release.key \
	  | gpg --dearmor \
	    | tee /etc/apt/keyrings/devel_kubic_libcontainers_stable.gpg > /dev/null
echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/devel_kubic_libcontainers_stable.gpg]\
	      https://download.opensuse.org/repositories/devel:kubic:libcontainers:stable/xUbuntu_20.04/ /" \
	        | tee /etc/apt/sources.list.d/devel:kubic:libcontainers:stable.list > /dev/null
apt-get update -qq
apt-get -qq -y install podman

#apt -y update
#apt -y install docker.io
#pip install molecule molecule-docker
cd ../../../../../../../../../roles/node_exporter
ansible --version
#ansible-doc --list -j
#ls /root/ansible/lib/ansible
#ls /root
#ls /root/ansible
#ls /root/ansible/lib/ansible/executor

unset ANSIBLE_PYTHON_INTERPRETER
#unset ANSIBLE_CONNECTION_PATH
#unset ANSIBLE_LIBRARY
#unset ANSIBLE_COLLECTIONS_PATH
#unset ANSIBLE_PLAYBOOK_DIR
#unset ANSIBLE_PYTHON_MODULE_RLIMIT_NOFILE
#env

ansible-config dump --only-changed | cat

molecule -s podman test
