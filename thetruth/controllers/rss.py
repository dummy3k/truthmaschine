import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to

from thetruth.lib.base import BaseController, render

log = logging.getLogger(__name__)

class StatementController(BaseController):
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
        