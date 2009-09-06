import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to

from thetruth.lib.base import BaseController, render
import thetruth.lib.helpers as h
import thetruth.model as model
from thetruth.model import meta

log = logging.getLogger(__name__)
#model.init_model(engine)

class HelloController(BaseController):

    def index(self):
        # Return a rendered template
        #return render('/hello.mako')
        # or, return a response
        
        #return 'Hello Pylons World!'
        c.myTest = 'fooBAR'
        return render('/hello.mako')
        #return h.url_for(controller='hello', action='sayHello')


    def restricted(self):
        return "restricted"

    def free(self):
        #return "free"
        return redirect_to(controller='hello', action="restricted")
        
    def sayHello(self, name):
        return "Hello %s!" % name
        
    def addUser(self, name):
        aUser = model.User()
        aUser.name="foo"
        meta.Session.add(aUser)
        meta.Session.commit()
        return "added user '%s'." % name