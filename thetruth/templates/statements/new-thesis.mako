<%!
    from pylons import config
%>
<%inherit file="/layout-default.mako"/>\

<%def name="content()">
  <h1>Create a new Thesis to discuss</h1>

  % if c.previousMessage:
    ${self.argumentInput(None, None, c.previousMessage)}
  % else:
    ${self.argumentInput(None, None, '')}
  % endif
</%def>
<%def name="sidenav()">
    <h1>Rules</h1>
    
    <ul>
        <li>You've got only ${config['statement_length']} characters</li>
        <li>Try to back up your Arguments with links</li>
    </ul>
</%def>