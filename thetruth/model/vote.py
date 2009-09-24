from sqlalchemy import *
from thetruth.model import meta

votes_table = Table('votes', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('statementid', Integer, ForeignKey('statements.id')),
    Column('isupvote', Boolean),
    Column('created', DateTime),
)
	
class Vote(object):
    def __unicode__(self):
        return self.message

    __str__ = __unicode__

    def __repr__(self):
        return "<Vote>"

