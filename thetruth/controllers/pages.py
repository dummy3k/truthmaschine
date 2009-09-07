import logging
from cgi import escape

from pylons import request, response, session, tmpl_context as c
from pylons.controllers.util import abort, redirect_to
from pylons.decorators.secure import authenticate_form

from thetruth.lib.base import BaseController, render
from thetruth.lib.helpers import flash

#from thetruth.model import Argument
#from thetruth.model.meta import User

log = logging.getLogger(__name__)

class PagesController(BaseController):
	def home(self):
		return render('/pages/list-arguments.mako')