#!/bin/sh

import os
import platform
import re
import sys
import stat
import signal

from flup.server.fcgi import WSGIServer
from subprocess import Popen, PIPE

HERE = os.path.abspath(os.path.dirname(__file__))
sys.path.insert(0, os.path.join(HERE, "lib/python2.7/site-packages"))

jdownloader_pbi_path = "/usr/pbi/jdownloader-" + platform.machine()
jdownloader_etc_path = os.path.join(jdownloader_pbi_path, "etc")
jdownloader_mnt_path = os.path.join(jdownloader_pbi_path, "mnt")
jdownloader_fcgi_pidfile = "/var/run/fcgi_jdownloader.pid"
jdownloader_fcgi_wwwdir = os.path.join(jdownloader_pbi_path, "www")
jdownloader_control = "/usr/local/etc/rc.d/jdownloaderd"


def jdownloader_fcgi_start(args):
    if len(args) < 2:
        return False

    ip = args[0]
    port = long(args[1])

    pid = os.fork()
    if pid < 0:
        return False
    if pid != 0:
        sys.exit(0)

    os.setsid()

    os.environ['DJANGO_SETTINGS_MODULE'] = 'jdownloaderUI.settings'
    import django.core.handlers.wsgi
    app = django.core.handlers.wsgi.WSGIHandler()

    res = False
    with open(jdownloader_fcgi_pidfile, "wb") as fp:
        fp.write(str(os.getpid()))
        fp.close()

        res = WSGIServer(app, bindAddress=(ip, port)).run()

    return res


def jdownloader_fcgi_stop(args):
    res = False
    if os.access(jdownloader_fcgi_pidfile, os.F_OK):
        with open(jdownloader_fcgi_pidfile, "r") as fp:
            pid = long(fp.read())
            fp.close()

            os.kill(pid, signal.SIGHUP)
            res = True

    if os.access(jdownloader_fcgi_pidfile, os.F_OK):
        os.unlink(jdownloader_fcgi_pidfile)

    return res


def jdownloader_fcgi_status(args):
    res = False
    if os.access(jdownloader_fcgi_pidfile, os.F_OK):
        with open(jdownloader_fcgi_pidfile, "r") as fp:
            pid = long(fp.read())
            fp.close()
            res = True

    return res


def jdownloader_fcgi_configure(args):
    return True


def main(argc, argv):
    if argc < 2:
        sys.exit(1)

    commands = {
        'start': jdownloader_fcgi_start,
        'stop': jdownloader_fcgi_stop,
        'status': jdownloader_fcgi_status,
        'configure': jdownloader_fcgi_configure
    }

    if not commands.has_key(argv[0]):
        sys.exit(1)

    if not commands[argv[0]](argv[1:]):
        sys.exit(1)

    sys.exit(0)

if __name__ == '__main__':
    main(len(sys.argv), sys.argv[1:])
