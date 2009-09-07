import logging

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to

from thetruth.lib.base import BaseController, render
from thetruth.model import meta
import thetruth.model as model
import thetruth.lib.helpers as h

from openid.consumer.consumer import Consumer, SUCCESS, FAILURE, DiscoveryFailure
from openid.store.sqlstore import SQLiteStore 
from openid import sreg
from datetime import datetime
from pylons.decorators import rest

log = logging.getLogger(__name__)

class LoginController(BaseController):
    def __before__(self):
        self.openid_session = session.get("openid_session", {})
        log.debug("__before__.openid_session %s" % self.openid_session)
        
        con = meta.engine.raw_connection()
        #store = SQLiteStore(con, 'openid_ settings', 'openid_ associations', 'openid_ nonces');
        self.store = SQLiteStore(con);
        #store.createTables()
        
        c.message = session['message']

        
    @rest.dispatch_on(POST="update_account")
    def index(self):
        if not c.user:
            redirect_to(action='signin')
        return render('login/account.index')

#    @validate(template='account.index', schema=schema.UpdateUser(), form='index',
#              variable_decode=True)
    def update_account(self):
        log.debug('update_account()')
        
        if 'language' in request.POST:
            redirect_to(action='index', id=None)
        print request.POST
        query = meta.Session.query(model.User)
        user = query.filter_by(openid=request.POST['openid']).first()
        user.name = request.POST['name']
        if 'email' in request.POST:
            user.email = request.POST['email']
        user.tzinfo = request.POST['tzinfo']
        #user.language = request.POST['language']
        meta.Session.commit()
        redirect_to(action='index')

    @rest.dispatch_on(POST="signin_POST")
    def signin(self):
        log.debug("enter signin()")
        if c.user:
            session['message'] = _('Already signed in.')
            session.save()
            redirect_to(action='index')
            

        #session.clear()
        return render('login/account.signin')

    def signin_POST(self):
        log.debug("enter signin_POST()")
        problem_msg = 'A problem ocurred comunicating to your OpenID server. Please try again.'

        self.consumer = Consumer(self.openid_session, self.store)
        openid = request.params.get('openid', None)
        if openid is None:
            log.warn("openid is None")
            session['message'] = problem_msg
            session.save()
            return render('login/account.signin')
        try:
            authrequest = self.consumer.begin(openid)
        except DiscoveryFailure, e:
            log.warn(e)
            session['message'] = problem_msg
            session.save()
            return redirect_to(action='signin')
        sreg_request = sreg.SRegRequest(
            #required=['email'],
            optional=['fullname', 'timezone', 'language', 'email']
        )

        authrequest.addExtension(sreg_request)
        redirecturl = authrequest.redirectURL(h.url_for('/', qualified=True),
            #h.url_for(controller='main', action='index', qualified=True),
            return_to=h.url_for(action='verified', qualified=True),
            immediate=False
        )
        log.debug("redirecturl: %s" % redirecturl)
        session['openid_session'] = self.openid_session
        session.save()
        return redirect_to(redirecturl)

    def verified(self):
        log.debug("enter verified()")
        log.debug("openid_session = %s" % self.openid_session)
        problem_msg = 'A problem ocurred comunicating to your OpenID server. Please try again.'
        self.consumer = Consumer(self.openid_session, self.store)
        info = self.consumer.complete(request.params,
                                      (h.url_for(action='verified',
                                                 qualified=True)))
        if info.status == SUCCESS:
            query = meta.Session.query(model.User)
            user = query.filter_by(openid=info.identity_url).first()
            if user is None:
                user = model.User()
                user.openid=info.identity_url
                #meta.Session.add(user)
                #meta.Session.commit()
                log.debug("first contact with user '%s'" % info.identity_url)
                
            if user.banned:
                redirect_to(action='banned')
                
            user.updatelastlogin()
            sreg_response = sreg.SRegResponse.fromSuccessResponse(info)
            user.name = sreg_response.get('fullname', u'')
            user.email = sreg_response.get('email', u'')
#            user.tzinfo = sreg_response.get('timezone', u'')
#            user.tzinfo = sreg_response.get('language', u'')
#            meta.Session.save(user)
            meta.Session.commit()
            #session.clear()
            session['openid'] = info.identity_url
            session['message'] = "Signed in"
            session['user'] = user
            session.save()
            log.debug('on verified before session check')
#            if 'redirected_from' in session:
#                url = session['redirected_from']
#                del(session['redirected_from'])
#                session.save()
#                return redirect_to(url)

#            log.debug('go to index')
            return redirect_to(controller='pages', action='home')
        else:
            log.warn("verified, but no success")
            log.debug("info: %s" % info)
            session['message'] = problem_msg
            session.save()
            return redirect_to(action='signin')

    def signout(self):
        if not c.user:
            session['message'] = "You are not signed in."
            session.save()
            redirect_to(action='showMessage')
        session.clear()
        session['message'] = "You've been signed out."
        session.save()
        redirect_to(controller='pages', action='home')

    def banned(self):
        if not c.user:
            session['message'] = _("You are not signed in.")
            session.save()
            redirect_to(action='signin')
        if not c.user.banned:
            session['message'] = _("You are not banned.")
            session.save()
            redirect_to(action='index')
        return render('login/account.banned')

    def showMessage(self):
        return render('login/message.mako')
        
    def signedin(self):
        return session['signedin']
        