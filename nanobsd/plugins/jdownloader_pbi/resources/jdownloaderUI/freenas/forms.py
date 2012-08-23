import os
import platform
import pwd

from django.utils.translation import ugettext_lazy as _

from dojango import forms
from JDownloaderUI.freenas import models, utils


class JDownloaderForm(forms.ModelForm):

    class Meta:
        model = models.JDownloader
        #widgets = {
        #    'admin_pw': forms.widgets.PasswordInput(),
        #}
        exclude = (
            'enable',
            )

    def __init__(self, *args, **kwargs):
        self.jail = kwargs.pop('jail')
        super(JDownloaderForm, self).__init__(*args, **kwargs)

        #if self.instance.admin_pw:
        #    self.fields['admin_pw'].required = False

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
