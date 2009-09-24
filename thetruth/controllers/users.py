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
        
    def showPublicProfile(self, id):
        users_q = meta.Session.query(model.User)
        c.user = users_q.filter(model.User.id==id).one()
        return render('/users/detail.mako')
        
    def showPrivateProfile(self, id):
        if not c.user:
            redirect_to(action='showPublicProfile', id=id)

        if int(c.user.id) != int(id):
            redirect_to(action='showPublicProfile', id=id)

        users_q = meta.Session.query(model.User)
        c.user = users_q.filter(model.User.id==id).one()
        return render('/users/edit.mako')
        
    def showProfile(self, id):
        if not c.user:
            redirect_to(action='showPublicProfile', id=id)

        log.debug("c.user.id = %s, id = %s" % (c.user.id, id))
        if int(c.user.id) == int(id):
            redirect_to(action='showPrivateProfile', id=id)
        else:
            redirect_to(action='showPublicProfile', id=id)
                                
        return "That should not happen."

    def saveProfile(self):
        if not c.user:
            log.debug('redirecting to signin, becuase user is not logged in')
            redirect_to(controller='login', action='signin')

        userId = request.params.get('id', None)
        userId = int(userId)            
        if int(c.user.id) != userId:
            log.debug('redirecting to signin, becuase user wants to change other users data')
            redirect_to(controller='login', action='signin')

        users_q = meta.Session.query(model.User)
        aUser = users_q.filter(model.User.id==userId).one()
        aUser.name = request.params.get('name', None)
        meta.Session.update(aUser)
        meta.Session.commit()
        
        #return render('/users/edit.mako')
        redirect_to(action='showProfile', id=userId)
        
