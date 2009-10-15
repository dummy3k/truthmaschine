import logging
from cgi import escape

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form

from pylons import config
from paste.deploy.converters import asbool
from gettext import gettext as _

from thetruth.lib.search import Search 

from thetruth.lib.base import BaseController, render
from thetruth.lib.helpers import flash
from thetruth.lib.markup import stripMarkup
from thetruth.model import meta
import thetruth.model as model
import thetruth.lib.helpers as h
from thetruth.lib.base import *

from pylons.i18n import get_lang, set_lang
from datetime import datetime

log = logging.getLogger(__name__)

statement_length = config['statement_length']

search = Search()

class StatementsController(BaseController):
    def __before__(self):
        pass
    
    def index(self):
        query = meta.Session.query(model.Statement)
        #rs = query.filter_by(parentid=None).select()
        c.thesis = query.filter_by(parentid=None).order_by(model.Statement.votes.desc()).all()
        if c.thesis:
            for aThesis in c.thesis:
                aThesis.attachTrueFalseCount()
           
        return render('/statements/list-thesis.mako')
        
    
    def newThesis(self):
        if not c.user:
            session['returnTo'] = {'controller': 'statements', 'action': 'newThesis'}
            session.save()
            redirect_to(controller='login', action='signin', id=None, istrue=None)
            
        c.title = _("New Thesis")
        return render('/statements/new-thesis.mako')

    def newArgument(self, id, istrue):
        if not c.user:
            session['returnTo'] = {'controller': 'statements', 'action': 'newArgument', 'id': id, 'istrue': istrue}
            session.save()
            redirect_to(controller='login', action='signin', id=None, istrue=None)
            
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
        if id == '0':
            return redirect_to(action='index', id=None)
                
        query = meta.Session.query(model.Statement)
        c.thesis = query.filter_by(id=id).first().attachTrueFalseCount()
        c.title = c.thesis

        c.feeds = [{'title': _('Arguments for this thesis'),
                    'link': config['base_url'] + h.url_for(controller='rss', action='showLastStatementsAsRssByStatement')}]
        
        if not c.thesis:
            abort(404)
            
        if c.thesis.parentid != 0:
            c.parentthesis = query.filter_by(id=c.thesis.parentid).first()
            
        c.trueArguments = query.filter_by(parentid=id,istrue=1).order_by(model.Statement.votes.desc()).all()
        
        for trueArgument in c.trueArguments:
            trueArgument.attachTrueFalseCount()
        
        c.falseArguments = query.filter_by(parentid=id,istrue=0).order_by(model.Statement.votes.desc()).all()
        for falseArgument in c.falseArguments:
            falseArgument.attachTrueFalseCount()

        return render('/statements/list-arguments.mako')
    
    def createNew(self):
        if not c.user:
            redirect_to(controller='login', action='signin', id=None, istrue=None)
                
        message = request.params.get('msg', None)
        
        if not message:
            abort(500)
        
        parentId = request.params.get('parentid', None)
        isTrue = request.params.get('argistrue', None)
        
        if len(stripMarkup(message)) > int(statement_length):
            h.flash(_("Error: Only %s characters are allowed!") % statement_length)

            c.previousMessage = message
            
            if isTrue: 
                if isTrue == True:
                    isTrueString = "pro"
                else:
                    isTrueString = "contra"
                
                return self.newArgument(parentId, isTrueString)
            else:
                return self.newThesis()
        
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
        search.add_to_index_and_commit(rant)
        meta.Session.commit()
        

        if request.params.get('parentid', None):
            h.flash(_('You have posted a new thesis. <strong>Please vote it</strong> up if you think it\'s true or down if you think its not.'))
            redirect_to(action='show', id=rant.parentid)
        else:
            if isTrue == 'True':
                h.flash(_('You have posted a new pro argument. <strong>Please vote it</strong> up if you think it\'s true or down if you think its not.'))
            elif isTrue == 'False':
                h.flash(_('You have posted a new contra argument. <strong>Please vote it</strong> up if you think it\'s true or down if you think its not.'))
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
            session['returnTo'] = {'controller': 'statements', 'action': 'edit_statement', 'id': id}
            session.save()
            redirect_to(controller='login', action='signin')
        
        query = meta.Session.query(model.Statement)
        c.statement = query.filter_by(id=id).first()
        
        if c.statement.parentid and c.statement.parentid != 0:
            c.thesis = query.filter_by(id=c.statement.parentid).first()
            c.thesisid = c.statement.parentid
            
            if c.thesis.parentid and c.thesis.parentid != 0:
                c.parentthesis = query.filter_by(id=c.thesis.parentid).first()

        return render('/statements/edit_statement.mako')
    
    def post_edit_statement(self, id):
        if not c.user:
            # should not happen therefore no c.returnTo
            redirect_to(controller='login', action='signin', id=id)

        query = meta.Session.query(model.Statement)
        thesis = query.filter_by(id=id).first().attachTrueFalseCount()

        if not c.user.allow_edit(thesis):
            raise Exception('no you dont')
            
        newMsg = request.params.get('msg')
        
        if len(stripMarkup(newMsg)) > int(statement_length):
            h.flash(_("Error: Only %s characters are allowed!") % statement_length)
            c.previousMessage = newMsg
            return self.edit_statement(id)        
        
        thesis.message = newMsg
        
        meta.Session.commit()
        search.update_index(thesis)
        
        

        redirect_to(action='show', id=id)
        