from django.db import models


class JDownloader(models.Model):
    """
    Django model describing every tunable setting for jdownloader
    """

    enable = models.BooleanField(default=False)
    servername = models.CharField(max_length=500, default=':1', blank=True)
    always_scan = models.BooleanField(default=True)
