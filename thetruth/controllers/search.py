import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form

from pylons import config
from paste.deploy.converters import asbool
from gettext import gettext as _

from thetruth.lib.search import Search

from thetruth.lib.base import BaseController, render
from thetruth.lib.helpers import flash
from thetruth.lib.markup import stripMarkup
from thetruth.model import meta
import thetruth.model as model
import thetruth.lib.helpers as h
from thetruth.lib.base import *

from pylons.i18n import get_lang, set_lang
from datetime import datetime

log = logging.getLogger(__name__)

statement_length = config['statement_length']

search = Search()

class SearchController(BaseController):
    def __before__(self):
        pass
    
    def search(self):
        search_query = request.params.get('query', None)
        
        if not search_query:
            abort(500)
        
        query = meta.Session.query(model.Statement)
        
        results = []
        for result in search.search(search_query):
            statement = query.filter_by(id=result['id']).first()
            if statement:
                results.append(statement) 
        
        c.results = results
        c.query = search_query
        
        return render('/search/search.mako')
    
    def reindex(self):
        query = meta.Session.query(model.Statement)
        for statement in query.all():
            search.add_to_index(statement)
            
        search.commit_index()
        
        