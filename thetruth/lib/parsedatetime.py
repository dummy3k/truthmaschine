from babel.dates import format_timedelta
from datetime import datetime
from datetime import timedelta


from pylons.i18n import get_lang

def convertToHumanReadable(date_time):        
    if get_lang() != None:
        return "vor " + format_timedelta(datetime.now()-date_time,  locale='de_DE')    
    else:
        return format_timedelta(datetime.now()-date_time,  locale='en_US') + " ago"

