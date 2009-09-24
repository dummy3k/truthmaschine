from thetruth.tests import *

class TestStatementController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='statement', action='index'))
        # Test response...
