from sqlalchemy import *
from migrate import *
import migrate.changeset

__test__ = False

meta = MetaData(migrate_engine)

users_table = Table('users', meta.metadata,
    Column('id', Integer, primary_key=True),
    Column('name', String(100)),
    Column('email', String(100)),
    Column('openid', String(255)),
    Column('banned', Boolean)
)
col = Column('foo',String)

# be considered sqlite can't drop columns
# http://packages.python.org/sqlalchemy-migrate/changeset.html#changeset-system
# http://www.sqlite.org/lang_altertable.html

def upgrade():
    #col.create(users_table)
    pass
    
def downgrade():
    #col.drop(users_table)
    pass
