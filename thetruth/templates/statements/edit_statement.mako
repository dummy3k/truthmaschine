<%!
    from pylons import config
    import thetruth.model as model
    from datetime import datetime
%>
<%inherit file="/layout-default.mako"/>\

<%def name="content()">
    % if c.previousMessage:
        ${self.argumentEdit(c.statement.id, c.previousMessage)}
    % else:
        ${self.argumentEdit(c.statement.id, c.statement.message)}
    % endif
    
    <p>
        <a href="${h.url_for(controller='statements', action='show', id=c.statement.id)}">Cancel</a>
    </p>
</%def>
<%def name="sidenav()">
    <h1>${_('Read this')}</h1>
    
    <ul>
        <li>${_('Youve got only %s characters' % config['statement_length'])}</li>
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
            argument.message = c.statement.message
        argument.created = datetime.now()
        argument.true_count = 0
        argument.false_count = 0
    %>
    ${self.argumentOutput(argument)}
  </div>
</%def>
<%def name="thesisarea()">
    % if c.parentthesis:
        ${self.parentthesis(c.parentthesis)}
    % endif
    % if c.thesis:
        ${self.thesis(c.thesis)}
    % endif
</%def>