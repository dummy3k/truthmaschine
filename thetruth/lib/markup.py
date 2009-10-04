import re
import logging

log = logging.getLogger(__name__)

def renderMarkup(s):
    # order matters
    log.debug("0: " + s)
    s = re.sub('^(http://[^\\s]+?)$', '<a href="\\1">\\1</a>', s)
    log.debug("1: " + s)
    s = re.sub('(\\s)(http://[^\\s]+?)$', '\\1<a href="\\2">\\2</a>', s)
    log.debug("2: " + s)
    s = re.sub('^(http://[^\\s]+?)(\\s)', '<a href="\\1">\\1</a>\\2', s)
    log.debug("3: " + s)
    s = re.sub('(\\s)(http://.+?)(\\s)', '\\1<a href="\\2">\\2</a>\\3', s)
    log.debug("4: " + s)
    s = re.sub('\[(.+?)\|(.+?)\]', '<a href="\\1">\\2</a>', s)
    log.debug("5: " + s)
    return s
    
def stripMarkup(s):
    s = re.sub('\[(.+?)\|(.+?)\]', '\\2', s)
    return s
    
def stripMarkupAndTruncate(s):
    s = re.sub('\[(.+?)\|(.+?)\]', '\\2', s)
    return s[:100]
    