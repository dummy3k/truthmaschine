<%!
    from pylons import config
%>

<%inherit file="/layout-default.mako"/>


<%def name="thesisarea()">
    % if c.parentthesis:
        ${self.parentthesis(c.parentthesis)}
    % endif
    ${self.thesis(c.thesis)}
</%def>

<%def name="content()">
  % if c.istrue:
    <h1>Create a new Pro Argument</h1>
  % else:
    <h1>Create a new Contra Argument</h1>
  % endif

  % if c.previousMessage:  
    ${self.argumentInput(c.thesisid, c.istrue, previousMessage)}
  % else:
    ${self.argumentInput(c.thesisid, c.istrue, '')}
  % endif
</%def>

<%def name="sidenav()">
    <h1>Read this</h1>
    
    <ul>
        <li>You've got only ${config['statement_length']} characters</li>
        <li>Please back up your Arguments with links</li>
        <li>Be polite</li>
    </ul>
</%def>