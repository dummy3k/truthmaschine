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
    def __before__(self):
        pass    
    
    def index(self):
        query = meta.Session.query(model.Statement)
        #rs = query.filter_by(parentid=None).select()
        rs = query.filter_by(parentid=None).all()
        c.thesis = rs
        return render('/pages/list-thesis.mako')
        
    def new(self):
        if not c.user:
            redirect_to(controller='login', action='signin')
        return render('/pages/new-thesis.mako')
        
    def about(self):
        return render('/pages/about.mako')

    def show(self, id):
        query = meta.Session.query(model.Statement)
        c.thesis = query.filter_by(id=id).first()
        
        if not c.thesis:
            abort(404)
            
        c.trueArguments = query.filter_by(parentid=id,istrue=1).all()
        c.falseArguments = query.filter_by(parentid=id,istrue=0).all()

        return render('/pages/list-arguments.mako')

    def upvote(self, id):
        if not c.user:
            redirect_to(controller='login', action='signin')

        query = meta.Session.query(model.Statement)
        thesis = query.filter_by(id=id).first()

        if thesis.is_voted_by_user(c.user.id):
            redirect_to(action='show', id=id)

        vote = model.Vote()
        vote.isupvote = True
        vote.userid = c.user.id
        vote.statementid = id
        meta.Session.add(vote)
        
        thesis.votes += 1
        meta.Session.update(thesis)
        meta.Session.commit()

        redirect_to(action='show', id=id)
        
    def downvote(self, id):
        if not c.user:
            redirect_to(controller='login', action='signin')

        query = meta.Session.query(model.Statement)
        thesis = query.filter_by(id=id).first()
        
        if thesis.is_voted_by_user(c.user.id):
            redirect_to(action='show', id=id)

        vote = model.Vote()
        vote.isupvote = False
        vote.userid = c.user.id
        vote.statementid = id
        meta.Session.add(vote)

        thesis.votes -= 1
        meta.Session.update(thesis)
        meta.Session.commit()

        redirect_to(action='show', id=id)

    
    def createNew(self):
        if not c.user:
            redirect_to(controller='login', action='signin')
        
        rant = model.Statement()
        rant.message = request.params.get('msg', None)
        rant.userid = c.user.id
        rant.votes = 0
        
        parentId = request.params.get('parentid', None)
        isTrue = request.params.get('istrue', None)
        
        if parentId and isTrue :
            rant.parentid=parentId
    
            if isTrue == 'true':
                rant.istrue = 1
            elif isTrue == 'false':
                rant.istrue = 0
        
        meta.Session.add(rant)
        meta.Session.commit()

        if request.params.get('parentid', None):
            redirect_to(action='show', id=rant.parentid)
        else:
            redirect_to(action='show', id=rant.id)
        

    def appendSubStatment(self, child, isContra):
        #        query = meta.Session.query(model.User)
        #        user = query.filter_by(openid=info.identity_url).first()
        #        user = model.User()
        #        user.openid=info.identity_url
        #meta.Session.add(user)
        #meta.Session.commit()

        pass
