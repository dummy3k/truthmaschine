import re
import logging

log = logging.getLogger(__name__)

def renderMarkup(s):
    s = re.sub('\[(.+?)\|(.+?)\]', '<a href="\\1">\\2</a>', s)
    log.debug("1: " + s)
    
    s = re.sub('(^|\\s)(http://[^\\s "<>]+)($|\\s)', '\\1<a href="\\2">\\2</a>\\3', s)
    log.debug("2: " + s)
    return s
    
def stripMarkup(s):
    s = re.sub('\[(.+?)\|(.+?)\]', '\\2', s)
    return s
    
def stripMarkupAndTruncate(s):
    s = re.sub('\[(.+?)\|(.+?)\]', '\\2', s)
    
    if len(s) > 100:
        return s[:100] + "..."
    else:
        return s[:100]
    