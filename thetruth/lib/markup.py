import re

def renderMarkup(s):
    s = re.sub('\[(.*?)\|(.*?)\]', '<a href="\\1">\\2</a>', s)
    return s
    
def stripMarkup(s):
    s = re.sub('\[(.*?)\|(.*?)\]', '\\2', s)
    return s
    
def stripMarkupAndTruncate(s):
    s = re.sub('\[(.*?)\|(.*?)\]', '\\2', s)
    return s[:100]
    