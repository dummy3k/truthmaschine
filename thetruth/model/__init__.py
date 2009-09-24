"""The application's model objects"""
from sqlalchemy import *
from sqlalchemy import orm
import hashlib

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
    Column('banned', Boolean),
    Column('reputation', Integer),
    Column('signup', DateTime),
    Column('last_login', DateTime),
)

votes_table = Table('votes', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('statementid', Integer, ForeignKey('statements.id')),
    Column('isupvote', Boolean),
    Column('created', DateTime),
)
	
statements_table = Table('statements', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('message', String(140)),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('parentid', Integer, ForeignKey('statements.id')),
    Column('votes', Integer),
    Column('istrue', Boolean),
    Column('created', DateTime),
    Column('updated', DateTime),
)
	
class User(object):
    def __unicode__(self):
        return self.name

    def getHashedEmailAddress(self):
        if self.email:
            return hashlib.md5(self.email.strip().lower()).hexdigest()
        else:
            return hashlib.md5(self.openid.strip().lower()).hexdigest()
        
    def getDisplayName(self):
        if self.name:
            return self.name
        else:
            return "Unnamed User"

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

    def is_voted_by_user(self, userid):
        query = meta.Session.query(Vote)
        return query.filter_by(userid=userid, statementid=self.id).first() != None
    
    def is_upvoted_by_user(self, userid):
        query = meta.Session.query(Vote)
        return query.filter_by(userid=userid, statementid=self.id, isupvote=True).first() != None

    def is_downvoted_by_user(self, userid):
        query = meta.Session.query(Vote)
        return query.filter_by(userid=userid, statementid=self.id, isupvote=False).first() != None
    
class Vote(object):
    def __unicode__(self):
        return self.message

    
    __str__ = __unicode__

    def __repr__(self):
        return "<Vote>"

orm.mapper(User, users_table)
orm.mapper(Vote, votes_table, properties = {
    'user' : orm.relation(User),
    'statement' : orm.relation(Statement),
    })

orm.mapper(Statement, statements_table, properties = {
    'user' : orm.relation(User),
    })
orm.mapper(Statement, users_table, non_primary=True)
