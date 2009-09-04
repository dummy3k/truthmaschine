"""The application's model objects"""
from sqlalchemy import *
from sqlalchemy.ext.declarative import declarative_base

from thetruth.model import meta

Base = declarative_base()


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


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    name = Column(String(100))
    email = Column(String(100))
    openid = Column(String(255))

    
class Statement(Base):
    __tablename__ = "statements"

    id = Column(Integer, primary_key=True)
    message = Column(String(140))
    user_id = Column(Integer, ForeignKey('users.id'))
    votes = Column(Integer)

    pros = Column(Integer, ForeignKey('statements.id'))
    contras = Column(Integer, ForeignKey('statements.id'))


