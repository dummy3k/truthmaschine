<%inherit file="/layout-default.mako"/>\

<%def name="content()">
  <h1>Create a new Thesis to discuss</h1>

  % if c.message:
  <p class="error">
    ${c.message}
  </p>
  % endif
  
  ${self.argumentInput(None, None)}
</%def>
<%def name="sidenav()">
    <h1>Rules</h1>
    
    <ul>
        <li>You've got only 140 characters</li>
        <li>Try to back up your Arguments with links</li>
        <li></h1>
    </ul>
</%def>