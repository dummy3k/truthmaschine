import logging
from cgi import escape

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form

from pylons import config
from paste.deploy.converters import asbool
from thetruth.lib.base import *
from gettext import gettext as _

from thetruth.lib.base import BaseController, render
from pylons.i18n import get_lang, set_lang
from thetruth.lib.helpers import flash
from thetruth.lib.markup import stripMarkup
from thetruth.model import meta
import thetruth.model as model
import thetruth.lib.helpers as h
from thetruth.lib.rss import __get_rss__ 

from datetime import datetime

log = logging.getLogger(__name__)

class RssController(BaseController):
    def __before__(self):
        pass
    
    def index(self):
        redirect_to(action='showLastStatementsAsRss')

    def showLastStatementsAsRssByStatement(self, id):
        query = meta.Session.query(model.Statement).filter_by(parentid=id).order_by(model.Statement.updated.desc())
        return __get_rss__(query)
    
    def showLastStatementsAsRss(self):
        query = meta.Session.query(model.Statement).order_by(model.Statement.updated.desc())
        return __get_rss__(query)
        