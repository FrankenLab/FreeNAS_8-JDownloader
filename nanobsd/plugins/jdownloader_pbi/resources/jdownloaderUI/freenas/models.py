from django.db import models


class JDownloader(models.Model):
    """
    Django model describing every tunable setting for jdownloader
    """

    enable = models.BooleanField(default=False)
    x11_DISPLAY = models.CharField(max_length=500, default=':1', blank=True)
    xvfb_enable = models.BooleanField(default=True)
