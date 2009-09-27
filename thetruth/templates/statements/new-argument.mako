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
    <h1>${_('Create a new Pro Argument')}</h1>
  % else:
    <h1>${_('Create a new Contra Argument')}</h1>
  % endif

  % if c.previousMessage:  
    ${self.argumentInput(c.thesisid, c.istrue, previousMessage)}
  % else:
    ${self.argumentInput(c.thesisid, c.istrue, '')}
  % endif
</%def>

<%def name="sidenav()">
    <h1>${_('Read this')}</h1>
    
    <ul>
        <li>You've got only ${config['statement_length']} characters</li>
        <li>${_('Please back up your Arguments with links')}</li>
        <li>${_('Be polite')}</li>
    </ul>
</%def>