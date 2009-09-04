"""Setup the thetruth application"""
import logging

from thetruth.config.environment import load_environment

log = logging.getLogger(__name__)

def setup_app(command, conf, vars):
    """Place any commands to setup thetruth here"""
    load_environment(conf.global_conf, conf.local_conf)
