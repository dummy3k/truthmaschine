<%inherit file="/users/user-snippets.mako"/>\

<%def name="content()">
  <p>
    ${c.message}
  </p>
		<h1>${_('User details for %s') % c.show_user.name}</h1>

        <form cellspacing="0" cellpadding="0" action="${h.url_for(action='saveProfile')}">
        <table border="0" class="nicetable">
            <tr>
                <th>Gravatar</th>
                <td><a href="http://en.gravatar.com/emails"><img class="gravatar-big" src="http://www.gravatar.com/avatar/${c.show_user.getHashedEmailAddress()}.png" width="80" height="80" /></a></td>
            </tr>
            <tr>
                <th>Id</th>
                <td>${c.show_user.id}</td>
            </tr>
            <tr>
                <th>${_('Name')}</th>
                <td><input type='text' name='name' value='${c.show_user.name}' /></td>
            </tr>
            <tr>
                <th>${_('eMail')}</th>
                <td><input type='text' name='email' value='${c.show_user.email}' /></td>
            </tr>
            <tr>
                <th>${_('OpenId')}</th>
                <td>${c.show_user.openid}</td>
            </tr>
        </table>
        
        <input type='hidden' name='id' value='${c.user.id}' />
        <input type='submit' value='${_('Save')}' />
     </form>
     
    ${self.showUserVotes(c.show_user)}
    ${self.showRecentStatements(c.show_user)}
</%def>
<%def name="sidenav()">
    
</%def>