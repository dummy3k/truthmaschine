from sqlalchemy import *
from migrate import *
from openid.consumer.consumer import Consumer, SUCCESS, FAILURE, DiscoveryFailure
from openid.store.sqlstore import SQLiteStore, MySQLStore
from pylons import config 

def upgrade():
    con = migrate_engine.raw_connection()

    if migrate_engine.name == 'sqlite':
        store = SQLiteStore(con);
    else:
        store = MySQLStore(con);
    
    store.createTables()

def downgrade():
    con = migrate_engine.raw_connection()
    
    if migrate_engine.name == 'sqlite':
        store = SQLiteStore(con);
    else:
        store = MySQLStore(con);

    store.dropTables()

