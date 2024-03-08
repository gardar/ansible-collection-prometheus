from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

import os
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_directories(host):
    dirs = [
        "/etc/gitlab_ci_pipelines_exporter"
    ]
    for dir in dirs:
        d = host.file(dir)
        assert d.is_directory
        assert d.exists


def test_files(host):
    files = [
        "/etc/systemd/system/gitlab_ci_pipelines_exporter.service",
        "/usr/local/bin/gitlab_ci_pipelines_exporter",
    ]
    for file in files:
        f = host.file(file)
        assert f.exists
        assert f.is_file


def test_permissions_didnt_change(host):
    dirs = [
        "/etc",
        "/root",
        "/usr",
        "/var"
    ]
    for file in dirs:
        f = host.file(file)
        assert f.exists
        assert f.is_directory
        assert f.user == "root"
        assert f.group == "root"


def test_user(host):
    assert host.group("gl-ci-pipe-exp").exists
    assert "gl-ci-pipe-exp" in host.user("gl-ci-pipe-exp").groups
    assert host.user("gl-ci-pipe-exp").shell == "/usr/sbin/nologin"
    assert host.user("gl-ci-pipe-exp").home == "/"


def test_service(host):
    s = host.service("gitlab_ci_pipelines_exporter")
    try:
        assert s.is_running
    except AssertionError:
        # Capture service logs
        journal_output = host.run('journalctl -u gitlab_ci_pipelines_exporter --since "1 hour ago"')
        print("\n==== journalctl -u gitlab_ci_pipelines_exporter Output ====\n")
        print(journal_output)
        print("\n============================================\n")
        raise  # Re-raise the original assertion error


def test_protecthome_property(host):
    s = host.service("gitlab_ci_pipelines_exporter")
    p = s.systemd_properties
    assert p.get("ProtectHome") == "yes"


def test_socket(host):
    sockets = [
        "tcp://0.0.0.0:9256"
    ]
    for socket in sockets:
        s = host.socket(socket)
        assert s.is_listening
