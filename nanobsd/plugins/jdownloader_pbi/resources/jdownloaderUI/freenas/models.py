from django.db import models


class JDownloader(models.Model):
    """
    Django model describing every tunable setting for jdownloader
    """

    enable = models.BooleanField(default=False)
