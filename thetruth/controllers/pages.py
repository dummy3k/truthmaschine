import logging
from cgi import escape

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form

from pylons import config
from paste.deploy.converters import asbool

from thetruth.lib.base import BaseController, render
from thetruth.lib.helpers import flash
from thetruth.model import meta
import thetruth.model as model

from datetime import datetime

log = logging.getLogger(__name__)

class PagesController(BaseController):
    def __before__(self):
        pass    
    
    def attachTrueFalseCount(self, statement):
        query = meta.Session.query(model.Statement)
        statement.true_count = query.filter_by(parentid=statement.id,istrue=1).count()
        statement.false_count = query.filter_by(parentid=statement.id,istrue=0).count()
        
        return statement
    
    def index(self):
        query = meta.Session.query(model.Statement)
        #rs = query.filter_by(parentid=None).select()
        c.thesis = query.filter_by(parentid=None).order_by(model.Statement.votes.desc()).all()
        if c.thesis:
            for aThesis in c.thesis:
                self.attachTrueFalseCount(aThesis)
           
        return render('/pages/list-thesis.mako')
        
    def newThesis(self):
        if not c.user:
            redirect_to(controller='login', action='signin')
            
        return render('/pages/new-thesis.mako')

    def newArgument(self, id, istrue):
        if not c.user:
            redirect_to(controller='login', action='signin')
            
        query = meta.Session.query(model.Statement)
        c.thesis = query.filter_by(id=id).first()
        c.thesisid=id
        
        if istrue == "pro":
            c.istrue = True
        elif istrue == "contra":
            c.istrue = False
        else:
            abort(404)
             
        return render('/pages/new-argument.mako')
        
    def about(self):
        return render('/pages/about.mako')

    def show(self, id):
        query = meta.Session.query(model.Statement)
        c.thesis = self.attachTrueFalseCount(query.filter_by(id=id).first())
        
        if not c.thesis:
            abort(404)
            
        c.trueArguments = query.filter_by(parentid=id,istrue=1).order_by(model.Statement.votes.desc()).all()
        
        for trueArgument in c.trueArguments:
            self.attachTrueFalseCount(trueArgument)
        
        c.falseArguments = query.filter_by(parentid=id,istrue=0).order_by(model.Statement.votes.desc()).all()
        for falseArgument in c.falseArguments:
            self.attachTrueFalseCount(falseArgument)

        return render('/pages/list-arguments.mako')
    

    def upvote(self, id):
        if not c.user:
            redirect_to(controller='login', action='signin')

        query = meta.Session.query(model.Statement)
        thesis = query.filter_by(id=id).first()

        # ignore if author tries to vote 
        if asbool(config['debug']) == False and c.user.id == thesis.userid:
            redirect_to(action='show', id=id)

        # reset vote if already voted 
        if thesis.is_voted_by_user(c.user.id):
            query = meta.Session.query(model.Vote)
            vote = query.filter_by(userid=c.user.id, statementid=id).first()
            if vote.isupvote:
                thesis.votes -= 1
            else:
                thesis.votes += 1
            meta.Session.delete(vote)
            meta.Session.update(thesis)
            meta.Session.commit()
            
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
        
        # ignore if author tries to vote 
        if asbool(config['debug']) == False and c.user.id == thesis.userid:
            redirect_to(action='show', id=id)

        # reset vote if already voted 
        if thesis.is_voted_by_user(c.user.id):
            query = meta.Session.query(model.Vote)
            vote = query.filter_by(userid=c.user.id, statementid=id).first()
            if vote.isupvote:
                thesis.votes -= 1
            else:
                thesis.votes += 1
            meta.Session.update(thesis)
            meta.Session.delete(vote)
            meta.Session.commit()
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
                
        message = request.params.get('msg', None)
        
        rant = model.Statement()
        rant.message = message[:140]
        rant.userid = c.user.id
        rant.votes = 0
        rant.created = datetime.now()
        rant.updated = datetime.now()
        
        parentId = request.params.get('parentid', None)
        isTrue = request.params.get('argistrue', None)
        
        if parentId and isTrue :
            rant.parentid=parentId
    
            if isTrue == 'True':
                rant.istrue = 1
            elif isTrue == 'False':
                rant.istrue = 0
            else: 
                log.error("unknown value for isTrue: " + isTrue)
                abort(500)
        
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
