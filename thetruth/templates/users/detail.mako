<%inherit file="/layout-default.mako"/>\

<%def name="content()">
  <p>
    ${c.message}
  </p>

		<h1>User details for ${c.user.name}</h1>

        <table border=1>
            <tr>
                <td><a href="http://en.gravatar.com/emails">Gravatar</a></td>
                <td><img class="gravatar-big" src="http://www.gravatar.com/avatar/${c.user.getHashedEmailAddress()}.jpg" /></td>
            </tr>
            <tr>
                <td>${_('Name')}</td>
                <td>${c.user.name}</td>
            </tr>
        </table>

</%def>
<%def name="sidenav()">
    
</%def>