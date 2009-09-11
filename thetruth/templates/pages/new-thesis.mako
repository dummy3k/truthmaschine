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
        <li>Rule 1: You do not talk about THE TRUTH (tm)</li>
        <li>Rule 2: You DO NOT talk about THE TRUTH (tm)</li>
        <li>Rule 3: ... todo ...</h1>
    </ul>
</%def>