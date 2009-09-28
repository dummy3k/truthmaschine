<%!
    from pylons import config
    import thetruth.model as model
    from datetime import datetime
%>
<%inherit file="/layout-default.mako"/>\

<%def name="content()">
  <h1>${_('Create a new Thesis to discuss')}</h1>

  % if c.previousMessage:
    ${self.topicInput(None, None, c.previousMessage)}
  % else:
    ${self.topicInput(None, None, '')}
  % endif
  

</%def>
<%def name="sidenav()">
    <h1>${_('Rules')}</h1>
    
    <ul>
        <li>${_('Youve got only %s characters') % config['statement_length']}</li>
        <li>${_('Try to back up your Arguments with links')}</li>
    </ul>  
    
    <div id="preview">
    <h3>${_('Preview: ')}</h1>
    <% 
        argument = model.Statement()
        argument.id = 0
        argument.istrue = True
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