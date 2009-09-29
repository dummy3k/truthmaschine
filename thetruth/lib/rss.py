import PyRSS2Gen
from pylons import config
import thetruth.lib.helpers as h
from datetime import datetime
from gettext import gettext as _

def __get_rss__(query):
    myItems = []
    for theArgument in query[:11]:
        newItem = PyRSS2Gen.RSSItem(
            title = theArgument.message,
            link = config['base_url'] + h.url_for(controller='statements', action='show', id=str(theArgument.id)),
            description = theArgument.message,
            guid = PyRSS2Gen.Guid(str(theArgument.id), False), #entry['guidislink']
            pubDate = theArgument.created)
        
        myItems.append(newItem)

    rss = PyRSS2Gen.RSS2(
        title = _("the Truth: Latest Statements"),
        link = config['base_url'],
        description = _("The latest statements from the Truth (tm)"),
        lastBuildDate = datetime.now(),
        items = myItems)

    return rss.to_xml()