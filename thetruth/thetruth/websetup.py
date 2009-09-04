"""Setup the thetruth application"""
import logging

from thetruth.config.environment import load_environment
from thetruth.model import meta

log = logging.getLogger(__name__)

def setup_app(command, conf, vars):
    """Place any commands to setup thetruth here"""
    load_environment(conf.global_conf, conf.local_conf)

    # Create the tables if they don't already exist
    log.info("Creating tables...")
    meta.metadata.create_all(bind=meta.engine)
    log.info("Successfully set up.")

	
#    log.info("Adding front page data...")
#    page = model.Page(title=u'FrontPage',
#                      content=u'**Welcome** to the QuickWiki front page!')
#    meta.Session.add(page)
#    meta.Session.commit()
#    log.info("Successfully set up.")
