from sqlalchemy import *
from migrate import *
import migrate.changeset

meta = MetaData(migrate_engine)

users_table = Table('users', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(100)),
    Column('email', String(100)),
    Column('openid', String(255)),
    Column('banned', Boolean),
)

# new user columns
user_reputation = Column('reputation', Integer)
user_signup = Column('signup', DateTime)
user_last_login = Column('last_login', DateTime)

statements_table = Table('statements', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('message', String(140)),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('parentid', Integer, ForeignKey('statements.id')),
    Column('votes', Integer),
    Column('istrue', Boolean),
)

statement_created = Column('created', DateTime)
statement_updated = Column('updated', DateTime)

votes_table = Table('votes', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('statementid', Integer, ForeignKey('statements.id')),
    Column('isupvote', Boolean),
    Column('created', DateTime),
)

# be considered sqlite can't drop columns
# http://packages.python.org/sqlalchemy-migrate/changeset.html#changeset-system
# http://www.sqlite.org/lang_altertable.html

def upgrade():
    statement_created.create(statements_table)
    statement_updated.create(statements_table)

    user_signup.create(users_table)
    user_last_login.create(users_table)
    user_reputation.create(users_table)
    
    votes_table.create()
    pass
    
def downgrade():
    statement_created.drop(statements_table)
    statement_updated.drop(statements_table)

    user_signup.drop(users_table)
    user_last_login.drop(users_table)
    user_reputation.drop(users_table)

    votes_table.drop()
    pass
