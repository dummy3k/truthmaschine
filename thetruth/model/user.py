from sqlalchemy import *
from thetruth.model import meta
from statement import Statement
from vote import Vote
import hashlib
from datetime import datetime

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

    def get_latest_statements(self, count=10):
        query = meta.Session.query(Statement)
        statements = query.filter_by(userid=self.id) \
            .order_by(Statement.created.desc())      \
            .limit(count)
            
        return statements
    
    def attach_vote_count(self):
        query = meta.Session.query(Vote)
        self.upvote_count = query.filter_by(userid=self.id, isupvote=1).count()
        self.downvote_count = query.filter_by(userid=self.id, isupvote=0).count()

    def updatelastlogin(self):
        self.last_login = datetime.now()
        pass
    
    def allow_edit(self, some_thing):
        if not some_thing:
            raise Exception('something isnt anything')
            
        if type(some_thing) is Statement:
            return (some_thing.userid == self.id)
        
        raise Exception('unknown type "%s"' % some_thing)
        
        