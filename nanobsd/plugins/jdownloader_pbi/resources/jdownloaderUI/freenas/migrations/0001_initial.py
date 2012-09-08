# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'JDownloader'
        db.create_table('freenas_jdownloader', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('enable', self.gf('django.db.models.fields.BooleanField')(default=False)),
            ('servername', self.gf('django.db.models.fields.CharField')(default=':1', max_length=500, blank=False)),
            ('always_scan', self.gf('django.db.models.fields.BooleanField')(default=True)),
        ))
        db.send_create_signal('freenas', ['JDownloader'])


    def backwards(self, orm):
        # Deleting model 'JDownloader'
        db.delete_table('freenas_jdownloader')


    models = {
        'freenas.jdownloader': {
            'Meta': {'object_name': 'JDownloader'},
            'enable': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'})
        }
    }

    models = {
        'freenas.jdownloader': {
            'Meta': {'object_name': 'JDownloader'},
            'always_scan': ('django.db.models.fields.BooleanField', [], {'default': 'True'}),
            'enable': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'servername': ('django.db.models.fields.CharField', [], {'default': "':1'", 'max_length': '500', 'blank': 'True'})
        }
    }


    complete_apps = ['freenas']
