import os

from django.apps import AppConfig


class InfoConfig(AppConfig):
    name = 'info'

    def ready(self):
        if os.environ.get('VERCEL') or os.path.exists('/var/task'):
            from django.contrib.auth.models import update_last_login
            from django.contrib.auth.signals import user_logged_in

            user_logged_in.disconnect(update_last_login)
