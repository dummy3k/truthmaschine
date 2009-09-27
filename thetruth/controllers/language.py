import logging
from cgi import escape

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form
from thetruth.lib.base import *
from gettext import gettext as _

from pylons import config
from paste.deploy.converters import asbool
from pylons.i18n import get_lang, set_lang

from thetruth.lib.base import BaseController, render
from thetruth.lib.helpers import flash
from thetruth.lib.markup import stripMarkup
from thetruth.model import meta
import thetruth.model as model
import thetruth.lib.helpers as h
from thetruth.lib.rss import __get_rss__ 

from datetime import datetime

log = logging.getLogger(__name__)

class LanguageController(BaseController):
    def __before__(self):
        if 'lang' in session:
            set_lang(session['lang'])
    
    def index(self):
        redirect_to(action='showLastStatementsAsRss')

    def set_lang(self, language):
        session['lang'] = language
        session.save()
        