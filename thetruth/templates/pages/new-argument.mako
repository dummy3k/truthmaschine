<%inherit file="/layout-default.mako"/>\


<%def name="thesisarea()">
    ${self.thesis()}
</%def>

<%def name="content()">
  % if c.istrue:
  <h1>Create a new Pro Argument</h1>
  % else:
  <h1>Create a new Contra Argument</h1>
  % endif

  % if c.message:
  <p class="error">
    ${c.message}
  </p>
  % endif
  
  ${self.argumentInput(c.thesis.id, c.istrue)}
</%def>
<%def name="sidenav()">
    <h1>Read this</h1>
    
    <ul>
        <li>You've got only 140 characters</li>
        <li>Please back up your Arguments with links</li>
        <li>Be polite</li>
    </ul>
</%def>