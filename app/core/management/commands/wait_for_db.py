"""
Djang command to wait for the database to be available
"""

import time
from psycopg2 import OperationalError as Psycopg2Error
from django.db.utils import OperationalError
from django.core.management import BaseCommand


class Command(BaseCommand):
    def handle(self, *args, **options):
        """Entrypoint for commands"""
        self.stdout.write('Waiting for database...')

        db_is_up = False
        while db_is_up is False:
            try:
                self.check(databases=['default'])
                db_is_up = True
            except (Psycopg2Error, OperationalError):
                self.stdout.write('Database unavailable, waiting 1 second....')
                time.sleep(1)

        self.stdout.write(self.style.SUCCESS('Database is UP!'))
