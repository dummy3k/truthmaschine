import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to

from thetruth.lib.base import BaseController, render

log = logging.getLogger(__name__)

class HelloController(BaseController):

    def index(self):
        # Return a rendered template
        #return render('/hello.mako')
        # or, return a response
        
        #return 'Hello Pylons World!'
        return render('/hello.mako')

    def restricted(self):
        return "restricted"

    def free(self):
        #return "free"
        return redirect_to(controller='hello', action="restricted")
        
    def addUser(self):
        return "Adding user"

