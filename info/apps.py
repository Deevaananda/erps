import os

from django.apps import AppConfig
from django.conf import settings


class InfoConfig(AppConfig):
    name = 'info'

    def ready(self):
        if not settings.DEBUG or os.environ.get('VERCEL') or os.path.exists('/var/task'):
            from django.contrib.auth.models import update_last_login
            from django.contrib.auth.signals import user_logged_in
            from django.contrib.auth import get_user_model

            user_logged_in.disconnect(update_last_login, sender=get_user_model(), dispatch_uid='update_last_login')
