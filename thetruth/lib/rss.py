import PyRSS2Gen
from pylons import config
import thetruth.lib.helpers as h
from datetime import datetime
from gettext import gettext as _
import markup  

def __get_rss__(query):
    myItems = []
    for theArgument in query[:11]:
        if not theArgument.parentid:
            argument_title = _("New Thesis")
        elif theArgument.istrue == 1:
            argument_title = _("New Pro-Argument for: ") + markup.stripMarkupAndTruncate(theArgument.get_parent_thesis().message)[:50]
        else: 
            argument_title = _("New Contra-Argument for: ") + markup.stripMarkupAndTruncate(theArgument.get_parent_thesis().message)[:50]
            
        newItem = PyRSS2Gen.RSSItem(
            title = argument_title,
            link = config['base_url'] + h.url_for(controller='statements', action='show', id=str(theArgument.id)),
            description = markup.renderMarkup(theArgument.message),
            guid = PyRSS2Gen.Guid(str(theArgument.id), False), #entry['guidislink']
            pubDate = theArgument.created)
        
        myItems.append(newItem)

    rss = PyRSS2Gen.RSS2(
        title = _("the Truth: Latest Statements"),
        link = config['base_url'],
        description = _("The latest statements from the Truth (tm)"),
        lastBuildDate = datetime.now(),
        items = myItems)

    return rss.to_xml("utf-8")