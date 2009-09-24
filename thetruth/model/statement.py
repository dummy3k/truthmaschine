from sqlalchemy import *
from thetruth.model import meta
from vote import Vote

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
    
