from sqlalchemy import *
from thetruth.model import meta
from statement import Statement

import hashlib
from datetime import datetime

comments_table = Table('comments', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('statementid', Integer, ForeignKey('statements.id')),
    Column('parentid', Integer, ForeignKey('comments.id')),
    Column('message', String(300)),
    Column('created', DateTime),
)

class Comment(object):
    def __unicode__(self):
        return "Comment #" + str(self.id) + ":" + self.message

    __str__ = __unicode__

    def __repr__(self):
        return "<Comment('%s', '%s')>" % (self.id, self.message)



