from sqlalchemy import *
from migrate import *
from pylons import config 

meta = MetaData(migrate_engine)

users_table = Table('users', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(100)),
    Column('email', String(100)),
    Column('openid', String(255)),
    Column('banned', Boolean)
)
	
statements_table = Table('statements', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('message', String(int(config['statement_length']))),
    Column('userid', Integer, ForeignKey('users.id')),
    Column('parentid', Integer, ForeignKey('statements.id')),
    Column('votes', Integer),
    Column('istrue', Boolean)

)

def upgrade():
    # Upgrade operations go here. Don't create your own engine; use the engine
    # named 'migrate_engine' imported from migrate.
    users_table.create()
    statements_table.create()

def downgrade():
    # Operations to reverse the above upgrade go here.
    users_table.drop()
    statements_table.drop()
