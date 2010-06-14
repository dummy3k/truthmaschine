from thetruth.tests import *

class TestStatementController(TestController):

    def test_index(self):
        response = self.app.get(url(controller='statements', action='index'))
        # Test response...

    def setUp(self):
        self.config['offline_mode'] = True
        self.config['debug'] = True
        response = self.app.get(url(controller='login', action='offline_login'))

    def test_newThesis(self):
        response = self.app.get(url(controller='statements', action='newThesis'))
        #~ assert 'http://localhost/medium/mass_add' == response.location
        assert None == response.location
        assert 'New Thesis' in response

        #~ response2 = self.app.get(response.location)
