The Truth (tm)

Setting up the Development Environment
======================================

To set up the Virtual Enviroment run:

    python go-pylons.py virtualenv
	
(Windows only) Add the virtualenv\Scripts folder to your %PATH%
(Linux only) Also run virtualenv/bin/easy_install -f http://pylonshq.com/download/ "Pylons==0.8" to get the paster executable

Then run

	cd pylons
	cd Scripts
	./activate
    
Installation and Setup
======================

Install ``thetruth`` using easy_install::

    easy_install thetruth-*.egg

Make a config file as follows::

    paster make-config thetruth production.ini

Tweak the config file as appropriate and then setup the application::

    paster setup-app config.ini

The Test-Webserver can be started with the following command in the ``thetruth`` directory

    paster serve --reload config.ini

	
Installing Dependencies
=======================
        
The following dependencies need to be installed

	easy_install sqlalchemy
	easy_install python-openid
    easy_install sqlalchemy-migrate	
    
Migrating the Database
======================

To create the initial Version Controlled Database which can be migrated use:

    python dbmanage.py version_control
    
To upgrade to the latest version use:

    python dbmanage.py version_control