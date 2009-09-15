"""The application's model objects"""
from sqlalchemy import *
from sqlalchemy import orm
import md5

from thetruth.lib.markup import renderMarkup
from thetruth.model import meta

def init_model(engine):
    """Call me before using any of the tables or classes in the model"""
    ## Reflected tables must be defined and mapped here
    #global reflected_table
    #reflected_table = Table("Reflected", meta.metadata, autoload=True,
    #                           autoload_with=engine)
    #orm.mapper(Reflected, reflected_table)
    #
    meta.Session.configure(bind=engine)
    meta.engine = engine


users_table = Table('users', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(100)),
    Column('email', String(100)),
    Column('openid', String(255)),
    Column('banned', Boolean)
)
	
statements_table = Table('statements', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('message', String(140)),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('parentid', Integer, ForeignKey('statements.id')),
    Column('votes', Integer),
    Column('istrue', Boolean)

)
	
class User(object):
    def __unicode__(self):
        return self.name

    def getHashedEmailAddress(self):
        if self.email:
            return md5.new(self.email.strip().lower()).hexdigest()
        else:
            return md5.new(self.openid.strip().lower()).hexdigest()
        
    def getDisplayName(self):
        if self.name:
            return self.name
        else:
            return self.openid    

    __str__ = __unicode__

    def __repr__(self):
        return "<User('%s', '%s')>" % (self.name, self.openid)
	
    def updatelastlogin(self):
        pass
    
class Statement(object):
    def __unicode__(self):
        return self.message

    __str__ = __unicode__

    def __repr__(self):
        return "<Statement('%s')>" % (self.message)


    def renderMessage(self):
        return renderMarkup(self.message)
    
orm.mapper(User, users_table)
orm.mapper(Statement, statements_table, properties = {
    'user' : orm.relation(User),
    })
orm.mapper(Statement, users_table, non_primary=True)
