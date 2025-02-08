from __future__ import (absolute_import, division, print_function)
__metaclass__ = type

from testinfra_helpers import get_target_hosts

testinfra_hosts = get_target_hosts()


def test_directories(host):
    dirs = [
        "/etc/apache_exporter"
    ]
    for dir in dirs:
        d = host.file(dir)
        assert d.is_directory
        assert d.exists


def test_files(host):
    files = [
        "/etc/systemd/system/apache_exporter.service",
        "//usr/local/bin/apache_exporter"
    ]
    for file in files:
        f = host.file(file)
        assert f.exists
        assert f.is_file


def test_user(host):
    assert host.group("apache-exp").exists
    assert "apache-exp" in host.user("apache-exp").groups
    assert host.user("apache-exp").shell == "/usr/sbin/nologin"


def test_service(host):
    s = host.service("apache_exporter")
    try:
        assert s.is_running
    except AssertionError:
        # Capture service logs
        journal_output = host.run('journalctl -u apache_exporter --since "1 hour ago"')
        print("\n==== journalctl -u apache_exporter Output ====\n")
        print(journal_output)
        print("\n============================================\n")
        raise  # Re-raise the original assertion error


def test_protecthome_property(host):
    s = host.service("apache_exporter")
    p = s.systemd_properties
    assert p.get("ProtectHome") == "yes"


def test_socket(host):
    sockets = [
        "tcp://127.0.0.1:9118"
    ]
    for socket in sockets:
        s = host.socket(socket)
        assert s.is_listening
