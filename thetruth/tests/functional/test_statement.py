from thetruth.tests import *

class TestStatementController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='statements', action='index'))
        # Test response...
