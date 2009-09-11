from sqlalchemy import *
from migrate import *
from openid.consumer.consumer import Consumer, SUCCESS, FAILURE, DiscoveryFailure
from openid.store.sqlstore import SQLiteStore 

meta = MetaData(migrate_engine)

oid_associations_table = Table('oid_associations', meta.metadata,
#    Column('id', Integer, primary_key=True),
    Column('server_url', String(2047)),
    Column('handle', String(255)),
    Column('secret', BLOB(128)),
    Column('issued', Integer),
    Column('lifetime', Integer),
    Column('assoc_type', String(64))
#    Column('PRIMARY KEY (server_url, handle)
)

oid_nonces_table = Table('oid_nonces', meta.metadata,
    Column('server_url', String),
    Column('timestamp', Integer),
    Column('salt', String(40))
        #UNIQUE(server_url, timestamp, salt)
)
 
def upgrade():
    # Upgrade operations go here. Don't create your own engine; use the engine
    # named 'migrate_engine' imported from migrate.
    oid_associations_table.create()
    oid_nonces_table.create()
    
def downgrade():
    # Operations to reverse the above upgrade go here.
    oid_associations_table.drop()
    oid_nonces_table.drop()
