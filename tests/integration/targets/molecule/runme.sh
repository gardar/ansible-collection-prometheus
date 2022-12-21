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
ls ../../../../../../host*


apt -y update
apt -y install docker.io
pip install molecule molecule-docker
cd ../../../../../../../../../roles/node_exporter
docker run hello-world
molecule test
