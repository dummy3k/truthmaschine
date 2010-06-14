The Truth (tm)

Setting up the Development Environment
======================================

Step 0: Download and install Python 2.6 and add the python executable to you PATH
Step 1: To set up the Virtual Enviroment run the following as a user with administrative rights: 

    python go-pylons.py virtualenv

Step 2 Windows:	Add the virtualenv\Scripts folder to your %PATH%
Step 2 Linux: Run virtualenv/bin/easy_install -f http://pylonshq.com/download/ "Pylons==0.8" to get the paster executable

Step 3: To activate the Virtual Environment run:
	cd virtualenv
	cd Scripts
	./activate

Step 4 Windows: Run script-1-install-project-dependencies.cmd
Step 4 Linux: 
    easy_install -f http://dl.dropbox.com/u/530973/py/index.html babel
    easy_install sqlalchemy python-openid sqlalchemy-migrate PyRSS2Gen http://dl.getdropbox.com/u/530973/Babel-1.0dev_r0-py2.6.egg
	
Step 5 Windows: Run script-2-delete-and-initialize-sqlite-db.cmd
Step 5 Linux: Run
	paster setup-app development.ini

Thats it. To run the development Webserver run:
    paster serve --reload development.ini

and visit http://localhost:5000/
    
Installation and Setup (Release Version)
========================================

Install ``thetruth`` using easy_install::

    easy_install thetruth-*.egg

Make a config file as follows::

    paster make-config thetruth production.ini

Tweak the config file as appropriate and then setup the application::

    paster setup-app production.ini

The Test-Webserver can be started with the following command in the ``thetruth`` directory

    paster serve --reload production.ini
	
On setting up thetruth for other webservers see the pylons documentation.
	

Migrating the Database
======================
    
To upgrade to the latest database schema version use:

    python dbmanage.py upgrade
	
Packaging
=========

You create an egg from this project by going into the project root directory and running the command:

    python setup.py bdist_egg

You will find the egg in the dist folder
