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


class VotesController(BaseController):
    
    def upvote(self, id):
        if not c.user:
            c.returnTo = {'controller': 'votes', 'action': 'upvote', 'id': id}
            return redirect_to(controller='login', action='signin', id=None)

        query = meta.Session.query(model.Statement)
        thesis = query.filter_by(id=id).first()

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
            
            return redirect_to(controller='statements', action='show', id=id)

        vote = model.Vote()
        vote.isupvote = True
        vote.userid = c.user.id
        vote.statementid = id
        meta.Session.add(vote)
        
        thesis.votes += 1
        meta.Session.update(thesis)
        meta.Session.commit()

        return redirect_to(controller='statements', action='show', id=id)
        
    def downvote(self, id):
        if not c.user:
            c.returnTo = {'controller': 'votes', 'action': 'downvote', 'id': id}
            return redirect_to(controller='login', action='signin', id=None)

        query = meta.Session.query(model.Statement)
        thesis = query.filter_by(id=id).first()

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
            
            return redirect_to(controller='statements', action='show', id=id)

        vote = model.Vote()
        vote.isupvote = False
        vote.userid = c.user.id
        vote.statementid = id
        meta.Session.add(vote)

        thesis.votes -= 1
        meta.Session.update(thesis)
        meta.Session.commit()

        return redirect_to(controller='statements', action='show', id=id)
