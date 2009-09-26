import logging
from cgi import escape

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form

from pylons import config
from paste.deploy.converters import asbool

from thetruth.lib.base import BaseController, render
from thetruth.lib.helpers import flash
from thetruth.lib.markup import stripMarkup
from thetruth.model import meta
import thetruth.model as model
import thetruth.lib.helpers as h

from datetime import datetime

log = logging.getLogger(__name__)

class StatementsController(BaseController):
    def index(self):
        query = meta.Session.query(model.Statement)
        #rs = query.filter_by(parentid=None).select()
        c.thesis = query.filter_by(parentid=None).order_by(model.Statement.votes.desc()).all()
        if c.thesis:
            for aThesis in c.thesis:
                self.attachTrueFalseCount(aThesis)
           
        return render('/statements/list-thesis.mako')
        

    def attachTrueFalseCount(self, statement):
        query = meta.Session.query(model.Statement)
        statement.true_count = query.filter_by(parentid=statement.id,istrue=1).count()
        statement.false_count = query.filter_by(parentid=statement.id,istrue=0).count()
        
        return statement
    
    def newThesis(self):
        if not c.user:
            c.returnTo = {'controller': 'statements', 'action': 'newThesis'}
            redirect_to(controller='login', action='signin')
            
        c.title = "New Thesis"
        return render('/statements/new-thesis.mako')

    def newArgument(self, id, istrue):
        if not c.user:
            c.returnTo = {'controller': 'statements', 'action': 'newArgument', 'id': id, 'istrue': istrue}
            redirect_to(controller='login', action='signin')
            
        query = meta.Session.query(model.Statement)
        c.thesis = query.filter_by(id=id).first()
        c.thesisid=id
        
        if c.thesis.parentid != 0:
            c.parentthesis = query.filter_by(id=c.thesis.parentid).first()
        
        if istrue == "pro":
            c.istrue = True
        elif istrue == "contra":
            c.istrue = False
        else:
            abort(404)
             
        return render('/statements/new-argument.mako')
    
    
    
    def show(self, id):
        query = meta.Session.query(model.Statement)
        c.thesis = self.attachTrueFalseCount(query.filter_by(id=id).first())
        c.title = c.thesis

        c.feeds = [{'title':'Arguments for this thesis',
                    'link': config['base_url'] + h.url_for(controller='pages', action='showLastStatementsAsRssByStatement')}]
        
        if not c.thesis:
            abort(404)
            
        if c.thesis.parentid != 0:
            c.parentthesis = query.filter_by(id=c.thesis.parentid).first()
            
        c.trueArguments = query.filter_by(parentid=id,istrue=1).order_by(model.Statement.votes.desc()).all()
        
        for trueArgument in c.trueArguments:
            self.attachTrueFalseCount(trueArgument)
        
        c.falseArguments = query.filter_by(parentid=id,istrue=0).order_by(model.Statement.votes.desc()).all()
        for falseArgument in c.falseArguments:
            self.attachTrueFalseCount(falseArgument)

        return render('/statements/list-arguments.mako')
    
    def createNew(self):
        if not c.user:
            c.returnTo = {'controller': 'statements', 'action': 'createMew'}
            redirect_to(controller='login', action='signin')
                
        message = request.params.get('msg', None)
        
        if not message:
            abort(500)
        
        parentId = request.params.get('parentid', None)
        isTrue = request.params.get('argistrue', None)
        
        if len(stripMarkup(message)) > 140:
            h.flash("Error: Only 140 characters are allowed!")

            c.previousMessage = message
            
            if isTrue == True:
                isTrueString = "pro"
            else:
                isTrueString = "contra"
            
            return self.newArgument(parentId, isTrueString)
        
        rant = model.Statement()
        rant.message = message
        rant.userid = c.user.id
        rant.votes = 0
        rant.created = datetime.now()
        rant.updated = datetime.now()
        
        
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
    
    
    def edit_statement(self, id):
        if not c.user:
            c.returnTo = {'controller': 'statements', 'action': 'edit_statement', 'id': id}
            redirect_to(controller='login', action='signin')
        
        query = meta.Session.query(model.Statement)
        c.thesis = self.attachTrueFalseCount(query.filter_by(id=id).first())

        #c.argument = 
        return render('/statements/edit_statement.mako')
    
    def post_edit_statement(self, id):
        if not c.user:
            # should not happen therefore no c.returnTo
            redirect_to(controller='login', action='signin', id=id)

        query = meta.Session.query(model.Statement)
        thesis = self.attachTrueFalseCount(query.filter_by(id=id).first())

        if not c.user.allow_edit(thesis):
            raise Exception('no you dont')
            
        newMsg = request.params.get('msg')
        if len(stripMarkup(newMsg)) > 140:
            c.message = "No many characters"
            return render('/pages/user_feedback.mako')
        
        thesis.message = newMsg
        meta.Session.commit()

        redirect_to(action='show', id=id)
        