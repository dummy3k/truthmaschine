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
from pylons.i18n import get_lang, set_lang
import thetruth.lib.helpers as h
from thetruth.lib.base import *
from gettext import gettext as _

from datetime import datetime


log = logging.getLogger(__name__)



class PagesController(BaseController):
    def __before__(self):
        if 'lang' in session:
            set_lang(session['lang'])
        pass
        
    def index(self):
        return redirect_to(controller='statements')
        
    def about(self):
        c.title = _("What's going on?")
        return render('/pages/about.mako')

    def faq(self):
        c.title = _("Frequently Asked Questions")
        return render('/pages/about.mako')
    

        