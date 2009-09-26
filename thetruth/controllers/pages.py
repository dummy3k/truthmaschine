import logging
from cgi import escape

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form

from pylons import config
from paste.deploy.converters import asbool

from thetruth.lib.base import BaseController, render
from thetruth.lib.helpers import flash
from thetruth.lib.markup import stripMarkup
from thetruth.model import meta
import thetruth.model as model
import thetruth.lib.helpers as h

from datetime import datetime


log = logging.getLogger(__name__)



class PagesController(BaseController):
    def __before__(self):
        pass    
        
    def index(self):
        return redirect_to(controller='statements')
        
    def about(self):
        c.title = "What's going on?"
        return render('/pages/about.mako')

    def faq(self):
        c.title = "What's going on?"
        return render('/pages/about.mako')
    

        