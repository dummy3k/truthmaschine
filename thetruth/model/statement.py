from sqlalchemy import *
from thetruth.model import meta
from vote import Vote
import logging

log = logging.getLogger(__name__)

statements_table = Table('statements', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('message', String(300)),
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

    def get_parent_thesis(self):
        if self.parentid == 0:
            return None
        
        query = meta.Session.query(Statement)
        return query.filter_by(id=self.parentid).first()

    def is_voted_by_user(self, userid):
        query = meta.Session.query(Vote)
        return query.filter_by(userid=userid, statementid=self.id).first() != None
    
    def is_upvoted_by_user(self, userid):
        query = meta.Session.query(Vote)
        return query.filter_by(userid=userid, statementid=self.id, isupvote=True).first() != None

    def is_downvoted_by_user(self, userid):
        query = meta.Session.query(Vote)
        return query.filter_by(userid=userid, statementid=self.id, isupvote=False).first() != None
    
    def attachTrueFalseCount(self):        
        query = meta.Session.query(Statement)
        self.true_count = query.filter_by(parentid=self.id,istrue=1).count()
        self.false_count = query.filter_by(parentid=self.id,istrue=0).count()
        
        if(self.true_count + self.false_count) > 0:
            self.proInPercent = float(self.true_count)/float(self.true_count+self.false_count)*100
        else:
            self.proInPercent = 50
        
        if self.proInPercent > 90:
            self.start_color = "0a6005"        
        elif self.proInPercent > 80:
            self.start_color = "1a5516"  
        elif self.proInPercent > 70:
            self.start_color = "234621"
        elif self.proInPercent > 60:
            self.start_color = "303e2f"
        elif self.proInPercent > 40:
            self.start_color = "2a2a2a"
        elif self.proInPercent > 30:
            self.start_color = "544242"
        elif self.proInPercent > 20:
            self.start_color = "563232"
        elif self.proInPercent > 10:
            self.start_color = "632625"
        else:
            self.start_color = "691110"
            
        return self
