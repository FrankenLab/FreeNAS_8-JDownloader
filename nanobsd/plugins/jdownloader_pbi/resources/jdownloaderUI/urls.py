from django.conf.urls.defaults import patterns, include, url

urlpatterns = patterns('',
     url(r'^plugins/jdownloader/', include('jdownloaderUI.freenas.urls')),
)
