"""The base Controller API

Provides the BaseController class for subclassing.
"""
from pylons.controllers.util import abort, redirect_to
from pylons.controllers import WSGIController
from pylons.templating import render_mako as render
from pylons import session, tmpl_context as c

from thetruth.model import meta
import thetruth.model as model

import logging
log = logging.getLogger(__name__)

from paste.deploy.converters import asbool
from pylons import config

class BaseController(WSGIController):

    def __call__(self, environ, start_response):
        """Invoke the Controller"""
        # WSGIController.__call__ dispatches to the Controller method
        # the request is routed to. This routing information is
        # available in environ['pylons.routes_dict']
        
        
        try:
            c.user = session['user']
        except:
            pass


        if asbool(config['debug']) and c.user:
            query = meta.Session.query(model.User)
            tmp = query.filter_by(id=c.user.id).first()
            if not tmp:
                log.debug('FOOOOOOO')
                c.user = None
                session['user'] = None
                #redirect_to(controller='login', action='signout')
            
        try:
            return WSGIController.__call__(self, environ, start_response)
        finally:
            meta.Session.remove()
            
        
