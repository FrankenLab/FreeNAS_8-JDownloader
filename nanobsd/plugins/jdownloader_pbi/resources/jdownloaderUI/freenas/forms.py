import os
import platform
import pwd

from django.utils.translation import ugettext_lazy as _

from dojango import forms
from jdownloaderUI.freenas import models, utils


class JDownloaderForm(forms.ModelForm):

    class Meta:
        model = models.JDownloader
        widgets = {
            'servername': forms.widgets.TextInput(),
        }
        exclude = (
            'enable',
            )

    def __init__(self, *args, **kwargs):
        self.jail = kwargs.pop('jail')
        super(JDownloaderForm, self).__init__(*args, **kwargs)

    def save(self, *args, **kwargs):
        obj = super(JDownloaderForm, self).save(*args, **kwargs)

        rcconf = os.path.join(utils.jdownloader_etc_path, "rc.conf")
        with open(rcconf, "w") as f:
            if obj.enable:
                f.write('jdownloader_enable="YES"\n')

            #jdownloader_flags = ""
            #for value in advanced_settings.values():
            #    jdownloader_flags += value + " "
            #f.write('jdownloader_flags="%s"\n' % (jdownloader_flags, ))

        os.system(os.path.join(utils.jdownloader_pbi_path, "tweak-rcconf"))


        try:
            os.makedirs("/var/cache/JDownloader")
            os.chown("/var/cache/JDownloader", *pwd.getpwnam('jdown')[2:4])
        except Exception:
            pass

        with open(utils.jdownloader_config, "w") as f:
            f.write("[general]\n")
            f.write("web_root = /usr/pbi/jdownloader-%s/etc/home/jdownloader\n" % (
                platform.machine(),
                ))
            f.write("db_type = %s\n" % ("sqlite3", ))
            f.write("db_params = %s\n" % ("/var/cache/JDownloader", ))
            f.write("servername = %s\n" % (obj.servername, ))
            f.write("runas = %s\n" % ("jdown", ))
            f.write("Enable Xvfb Virtual X11 Display = %d\n" % (obj.always_scan, ))
            f.write("\n[Must Be Enabled on first Run]\n")
