The Truth (tm)

Installation and Setup
======================

Install ``thetruth`` using easy_install::

    easy_install thetruth

Make a config file as follows::

    paster make-config thetruth config.ini

Tweak the config file as appropriate and then setup the application::

    paster setup-app config.ini

Then you are ready to go.

Setting up the Development Environment
======================================

To set up the Pylons Virtual Enviroment run

    python go-pylons.py pylons
	
(Windows only) Add the pylons\Scripts folder to your %PATH%

Then run

	cd pylons
	cd Scripts
	./activate
	
The following dependencies need to be installed

	easy_install sqlalchemy
	
The Test-Webserver can be started with the following command in the ``thetruth`` directory

    paster serve development.ini
	