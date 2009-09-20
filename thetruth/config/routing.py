"""Routes configuration

The more specific and detailed routes should be defined first so they
may take precedent over the more generic routes. For more information
refer to the routes manual at http://routes.groovie.org/docs/
"""
from pylons import config
from routes import Mapper

def make_map():
    """Create, configure and return the routes Mapper"""
    map = Mapper(directory=config['pylons.paths']['controllers'],
                 always_scan=config['debug'])
    map.minimization = False

    # The ErrorController route (handles 404/500 error pages); it should
    # likely stay at the top, ensuring it can always be resolved
    map.connect('/error/{action}', controller='error')
    map.connect('/error/{action}/{id}', controller='error')

    map.connect('/newArgument/{istrue}/{id}', controller="pages", action='newArgument')

    map.connect('/', controller="pages", action='index')
    
    map.connect('/newThesis', controller="pages", action="newThesis")
    map.connect('/newArgument/{istrue}/{id}', controller="pages", action="newArgument")
    map.connect('/newArgument/{istrue}/{id}/', controller="pages", action="newArgument")
    map.connect('/about', controller="pages", action="about")
    
    map.connect('/login', controller="login", action='signin')
    map.connect('/login/', controller="login", action='signin')
#    map.connect('/login/signin_POST', controller="login", action='signin_POST')
    
    map.connect('/logout', controller="login", action='signout')
    map.connect('/logout/', controller="login", action='signout')

    # Default Controller
#    map.connect('/{action}', controller="pages")
#    map.connect('/{action}/', controller="pages")
#    map.connect('/{action}/{id}', controller="pages")
#    map.connect('/{action}/{id}/', controller="pages")
    
    # CUSTOM ROUTES HERE
    map.connect('/{controller}', action='index')
    map.connect('/{controller}/', action='index')
    map.connect('/{controller}/{action}')
    map.connect('/{controller}/{action}/')
    map.connect('/{controller}/{action}/{id}')
    
    map.connect('/', controller='pages', action='index')
    
    return map
