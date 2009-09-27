<%!
    from pylons import config
    import thetruth.model as model
    from datetime import datetime
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
    % if c.istrue:
        ${self.argumentInput(c.thesisid, c.istrue, c.previousMessage, False)}
    %else:
        ${self.argumentInput(c.thesisid, c.istrue, c.previousMessage, True)}
    %endif
  % else:
    % if c.istrue:
        ${self.argumentInput(c.thesisid, c.istrue, '', False)}
    %else:
        ${self.argumentInput(c.thesisid, c.istrue, '', True)}
    %endif
  % endif
</%def>

<%def name="sidenav()">
    <h1>${_('Read this')}</h1>
    
    <ul>
        <li>You've got only ${config['statement_length']} characters</li>
        <li>${_('Please back up your Arguments with links')}</li>
        <li>${_('Be polite')}</li>
    </ul>    
    
    <div id="preview">
    <h3>${_('Preview: ')}</h1>
    <% 
        argument = model.Statement()
        argument.id = 0
        argument.istrue = c.istrue
        argument.user = c.user
        if c.previousMessage:
            argument.message = c.previousMessage
        else:
            argument.message = ''
        argument.created = datetime.now()
        argument.true_count = 0
        argument.false_count = 0
    %>
    ${self.argumentOutput(argument)}
  </div>
</%def>