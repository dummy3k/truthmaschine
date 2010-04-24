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

statements_table = Table('statements', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('message', String(140)),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('parentid', Integer, ForeignKey('statements.id')),
    Column('votes', Integer),
    Column('istrue', Boolean),
)


comments_table = Table('comments', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('statementid', Integer, ForeignKey('statements.id')),
    Column('parentid', Integer, ForeignKey('comments.id')),
    Column('message', String(300)),
    Column('created', DateTime),
)
# be considered sqlite can't drop columns
# http://packages.python.org/sqlalchemy-migrate/changeset.html#changeset-system
# http://www.sqlite.org/lang_altertable.html

def upgrade():
    comments_table.create()
    pass

def downgrade():
    comments_table.drop()
    pass
