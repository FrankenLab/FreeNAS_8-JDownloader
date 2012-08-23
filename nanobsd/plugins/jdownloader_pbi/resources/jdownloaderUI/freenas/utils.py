from subprocess import Popen, PIPE
import os
import platform

jdownloader_pbi_path = "/usr/pbi/jdownloader-" + platform.machine()
jdownloader_etc_path = os.path.join(jdownloader_pbi_path, "etc")
jdownloader_mnt_path = os.path.join(jdownloader_pbi_path, "mnt")
jdownloader_fcgi_pidfile = "/var/run/jdownloader.pid"
jdownloader_fcgi_wwwdir = os.path.join(jdownloader_pbi_path, "www")
jdownloader_control = "/usr/local/etc/rc.d/jdownloaderd"
jdownloader_config = os.path.join(jdownloader_etc_path, "jdownloader.conf")
jdownloader_icon = os.path.join(jdownloader_pbi_path, "default.png")
jdownloader_oauth_file = os.path.join(jdownloader_pbi_path, ".oauth")


def get_rpc_url(request):
    return 'http%s://%s/plugins/json-rpc/v1/' % ('s' if request.is_secure() \
            else '', request.get_host(),)


def get_jdownloader_oauth_creds():
    f = open(jdownloader_oauth_file)
    lines = f.readlines()
    f.close()

    key = secret = None
    for l in lines:
        l = l.strip()

        if l.startswith("key"):
            pair = l.split("=")
            if len(pair) > 1:
                key = pair[1].strip()

        elif l.startswith("secret"):
            pair = l.split("=")
            if len(pair) > 1:
                secret = pair[1].strip()

    return key, secret


jdownloader_advanced_vars = {
    "set_cwd": {
        "type": "checkbox",
        "on": "-a",
        },
    "debuglevel": {
        "type": "textbox",
        "opt": "-d",
        },
    "debug_modules": {
        "type": "textbox",
        "opt": "-D",
        },
    "disable_mdns": {
        "type": "checkbox",
        "on": "-m",
        },
    "non_root_user": {
        "type": "checkbox",
        "on": "-y",
        },
    "ffid": {
        "type": "textbox",
        "opt": "-b",
        },
}
