import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect
from thetruth.lib.base import *
from pylons import url

from thetruth.lib.base import BaseController, render
import thetruth.lib.helpers as h
import thetruth.model as model
from thetruth.model import meta
from pylons.i18n import get_lang, set_lang
from gettext import gettext as _

from datetime import datetime
from pylons import config
import PyRSS2Gen

log = logging.getLogger(__name__)
    
class UsersController(BaseController):
    def __before__(self):
        pass

    def index(self):
        # Return a rendered template
        #return render('/users.mako')
        # or, return a response
        return redirect(url(controller='users', action="showUsersList"))

    def showUsersList(self):
        users_q = meta.Session.query(model.User)
        c.users = users_q.all()
        c.links = [
            ('James','http://jimmyg.org'),
            ('Ben','http://groovie.org'),
            ('Philip',''),
        ]
        
        return render('/users/list.mako')
        
    def showProfile(self, id):
        query = meta.Session.query(model.User)
        c.show_user = query.filter(model.User.id == id).first()

        if not c.show_user: 
            abort(404)

        c.title = c.show_user.name

        if c.user and int(c.user.id) == int(id):
            return render('/users/edit.mako')
        else:
            return render('/users/detail.mako')
            
        return _("That should not happen.")

    def saveProfile(self):
        if not c.user:
            log.debug('redirecting to signin, because user is not logged in')
            redirect(url(controller='login', action='signin'))

        userId = request.params.get('id', None)
        userId = int(userId)            
        if int(c.user.id) != userId:
            log.debug('redirecting to signin, becuase user wants to change other users data')
            redirect(url(controller='login', action='signin'))

        users_q = meta.Session.query(model.User)
        aUser = users_q.filter(model.User.id==userId).one()
        aUser.name = request.params.get('name', None)
        aUser.email = request.params.get('email', None)
        meta.Session.update(aUser)
        meta.Session.commit()
        redirect(url(controller='users', action='showProfile', id=userId))
        
        
    def newUsersRss(self):
        query = meta.Session.query(model.User).order_by(model.User.signup.desc())
        myItems = []
        for it in query.all():
            newItem = PyRSS2Gen.RSSItem(
                title = it.getDisplayName(),
                link = config['base_url'] + h.url_for(action='showProfile', id=str(it.id)),
                description = it.getDisplayName(),
                guid = PyRSS2Gen.Guid(str(it.id), False), #entry['guidislink']
                pubDate = it.signup)
            
            myItems.append(newItem)

        rss = PyRSS2Gen.RSS2(
            title = _("the Truth: Latest Users"),
            link = config['base_url'],
            description = _("Latest users joining Truth (tm)"),
            lastBuildDate = datetime.now(),
            items = myItems)

        return rss.to_xml()

                
