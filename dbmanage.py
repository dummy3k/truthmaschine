#!/usr/bin/env python
from migrate.versioning.shell import main

main(url='sqlite:///database-dev.db',repository='db_repo')
