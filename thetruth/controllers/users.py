import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to

from thetruth.lib.base import BaseController, render
import thetruth.lib.helpers as h
import thetruth.model as model
from thetruth.model import meta

log = logging.getLogger(__name__)
    
class UsersController(BaseController):

    def index(self):
        # Return a rendered template
        #return render('/users.mako')
        # or, return a response
        return redirect_to(controller='users', action="showUsersList")

    def signIn(self, openIdUrl):
        pass
        
    def showUsersList(self):
        users_q = meta.Session.query(model.User)
        c.users = users_q.all()
        c.links = [
            ('James','http://jimmyg.org'),
            ('Ben','http://groovie.org'),
            ('Philip',''),
        ]
        
        return render('/user_list.mako')
        
    def add(self):
        aUser = model.User()
        aUser.name=request.params.get('name')
        meta.Session.add(aUser)
        meta.Session.commit()
        return redirect_to(action="showUsersList")
        
    def showDetails(self, id):
        users_q = meta.Session.query(model.User)
        c.user = users_q.filter(model.User.id==id).one()
        return render('/users/detail.mako')
        