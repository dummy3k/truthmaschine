"""Setup the thetruth application"""
import logging

from thetruth.config.environment import load_environment
from thetruth.model import meta

from openid.consumer.consumer import Consumer, SUCCESS, FAILURE, DiscoveryFailure
from openid.store.sqlstore import SQLiteStore 

import pylons.test
import migrate.versioning.api
from migrate.versioning.exceptions import DatabaseAlreadyControlledError
from pylons import config

log = logging.getLogger(__name__)

def setup_app(command, conf, vars):
    """Place any commands to setup thetruth here"""
    if not pylons.test.pylonsapp:
        load_environment(conf.global_conf, conf.local_conf)

    # Create the tables if they don't already exist
    #log.info("Creating tables...")
    #meta.metadata.create_all(bind=meta.engine)
    #log.info("Successfully set up.")

    con = meta.engine.raw_connection()
    #store = SQLiteStore(con, 'openid_ settings', 'openid_ associations', 'openid_ nonces');
    #store = SQLiteStore(con);
    #store.createTables()
        
#    log.info("Adding front page data...")
#    page = model.Page(title=u'FrontPage',
#                      content=u'**Welcome** to the QuickWiki front page!')
#    meta.Session.add(page)
#    meta.Session.commit()


    # setup db with sqlalchemy migrate
    dbUrl = config['sqlalchemy.url']
    log.debug('dbUrl: %s' % dbUrl)
    
    try:
        migrate.versioning.api.version_control(url=dbUrl,repository='db_repo')
    except DatabaseAlreadyControlledError:
        pass
        
    migrate.versioning.api.upgrade(url=dbUrl,repository='db_repo')


    log.info("Successfully set up.")
