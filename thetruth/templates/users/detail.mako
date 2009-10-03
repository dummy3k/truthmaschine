<%inherit file="/users/user-snippets.mako"/>\

<%def name="content()">
  <p>
    ${c.message}
  </p>

		<h1>${_('User details for %s') % c.user.name}</h1>

        <table border="0" cellspacing="0" cellpadding="0" class="nicetable">
            <tr>
                <th><a href="http://en.gravatar.com/emails">Gravatar</a></th>
                <td><img class="gravatar-big" src="http://www.gravatar.com/avatar/${c.show_user.getHashedEmailAddress()}.jpg" /></td>
            </tr>
            <tr>
                <th>${_('Name')}</th>
                <td>${c.show_user.name}</td>
            </tr>
        </table>

    ${self.showRecentStatements(c.show_user)}
</%def>
<%def name="sidenav()">
    
</%def>