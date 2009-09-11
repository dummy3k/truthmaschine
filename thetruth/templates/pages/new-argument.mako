<%inherit file="/layout-default.mako"/>\

<%def name="content()">
  <p>
    ${c.message}
  </p>

  <h1>Create a new Thesis to discuss</h1>

	<div class="hint">
		please phrase your text nicely ...
	</div>
	
  <form method="post" action="${h.url_for(action='createNew')}">
    <textarea name="msg"></textarea>
    <input type="submit" value="Submit" />
  </form>
</%def>
<%def name="sidenav()">
    blah
</%def>