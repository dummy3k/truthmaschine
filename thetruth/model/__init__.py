"""The application's model objects"""
from sqlalchemy import *
from sqlalchemy import orm

from thetruth.lib.markup import renderMarkup
from thetruth.model import meta

from user import User, users_table
from statement import Statement, statements_table
from vote import Vote, votes_table
from comment import Comment, comments_table

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


orm.mapper(User, users_table)
orm.mapper(Vote, votes_table, properties = {
    'user' : orm.relation(User),
    'statement' : orm.relation(Statement),
    })

orm.mapper(Statement, statements_table, properties = {
    'user' : orm.relation(User),
    'comments' : orm.relation(Comment),
    })
orm.mapper(Statement, users_table, non_primary=True)

orm.mapper(Comment, comments_table, properties = {
    'user' : orm.relation(User),
    'statement' : orm.relation(Statement),
    })
