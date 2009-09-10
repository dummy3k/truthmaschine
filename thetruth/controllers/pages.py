import logging
from cgi import escape

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form

from thetruth.lib.base import BaseController, render
from thetruth.lib.helpers import flash
from thetruth.model import meta
import thetruth.model as model

log = logging.getLogger(__name__)

class PagesController(BaseController):
    def home(self):
        return render('/pages/list-arguments.mako')


    def createNew(self):
        if not c.user:
            redirect_to(controller='login', action='signin')
        
        rant = model.Statement()
        rant.message = request.params.get('msg', None)
        rant.userid = c.user.id
        meta.Session.add(rant)
        meta.Session.commit()

    def appendSubStatment(self, child, isContra):
        #        query = meta.Session.query(model.User)
        #        user = query.filter_by(openid=info.identity_url).first()
        #        user = model.User()
        #        user.openid=info.identity_url
        #meta.Session.add(user)
        #meta.Session.commit()

        pass
