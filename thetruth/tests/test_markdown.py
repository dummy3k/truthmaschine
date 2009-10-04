from thetruth.tests import *
from thetruth.lib.markup import *

import logging

log = logging.getLogger(__name__)


class TestMarkup(TestController):

    def test_no_markup(self):
        self.assertEqual('Hello World!', renderMarkup('Hello World!'))

    def test_link(self):
        self.assertEqual('Hello <a href="foo.org">World!</a>', 
            renderMarkup('Hello [foo.org|World!]'))

        self.assertEqual('Hello World!', 
            stripMarkup('Hello [foo.org|World!]'))
            
    def test_two_links(self):
        self.assertEqual('<a href="blah.com">Hello</a> <a href="foo.org">World!</a>', 
            renderMarkup('[blah.com|Hello] [foo.org|World!]'))
        self.assertEqual('Hello World!', 
            stripMarkup('[blah.com|Hello] [foo.org|World!]'))



    def test_normal_http_url(self):
        self.assertEqual('Hello <a href="http://www.foo.org/dir/file.txt">' \
                         + 'http://www.foo.org/dir/file.txt</a> !', 
            renderMarkup('Hello http://www.foo.org/dir/file.txt !'))

    def test_only_http_url(self):
        self.assertEqual('<a href="http://www.foo.org/dir/file.txt">' \
                         + 'http://www.foo.org/dir/file.txt</a>', 
            renderMarkup('http://www.foo.org/dir/file.txt'))

        self.assertEqual(' <a href="http://www.foo.org/dir/file.txt">' \
                         + 'http://www.foo.org/dir/file.txt</a>', 
            renderMarkup(' http://www.foo.org/dir/file.txt'))

        self.assertEqual('<a href="http://www.foo.org/dir/file.txt">' \
                         + 'http://www.foo.org/dir/file.txt</a> ', 
            renderMarkup('http://www.foo.org/dir/file.txt '))

        self.assertEqual(' <a href="http://www.foo.org/dir/file.txt">' \
                         + 'http://www.foo.org/dir/file.txt</a> ', 
            renderMarkup(' http://www.foo.org/dir/file.txt '))

    def test_hardest_http_url(self):
        log.debug("START: ")
        
        input = renderMarkup('[http://web.de|hallo welt] http://www.foo.org/dir/file.txt')
        
        log.debug("END")
        self.assertEqual('<a href="http://web.de">' \
                         + 'hallo welt</a> ' \
                         + '<a href="http://www.foo.org/dir/file.txt">' \
                         + 'http://www.foo.org/dir/file.txt</a>', 
            input)

    
    def test_fq_url(self):
        self.assertEqual('Hello <b>World!</b>', 
            renderMarkup('Hello <b>World!</b>'))
    