"""The base Controller API

Provides the BaseController class for subclassing.
"""
from pylons.controllers.util import abort, redirect_to
from pylons.controllers import WSGIController
from pylons.templating import render_mako as render

from pylons import request, response, session, tmpl_context as c
from thetruth.model import meta
import thetruth.model as model
from pylons.i18n import get_lang, set_lang

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
        

        lang = request.params.get('language', None) 
        if lang and lang == 'de':
            session['lang'] = lang
        elif lang and lang == 'en':
            session['lang'] = lang

        if 'lang' in session: 
            if session['lang'] == 'de':
                set_lang(session['lang'])
        else:
            for ua_lang in request.languages:
                if ua_lang[0:2] == 'de':
                    session['lang'] = 'de'
                    break
                
                if ua_lang[0:2] == 'en':
                    session['lang'] = 'en'
                    
            if not 'lang' in session:
                session['lang'] = 'en'
                
            if session['lang'] == 'de':
                set_lang(session['lang'])
            
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
            
        
