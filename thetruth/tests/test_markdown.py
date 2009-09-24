from thetruth.tests import *
from thetruth.lib.markup import *

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

    def test_fq_url(self):
        self.assertEqual('Hello <a href="http://www.foo.org/dir/file.txt">World!</a>', 
            renderMarkup('Hello [http://www.foo.org/dir/file.txt|World!]'))
        self.assertEqual('Hello World!', 
            stripMarkup('Hello [http://www.foo.org/dir/file.txt|World!]'))

    def test_fq_url(self):
        self.assertEqual('Hello <b>World!</b>', 
            renderMarkup('Hello <b>World!</b>'))
    