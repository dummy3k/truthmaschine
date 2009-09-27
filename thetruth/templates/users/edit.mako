<%inherit file="/layout-default.mako"/>\

<%def name="content()">
  <p>
    ${c.message}
  </p>

		<h1>User details for ${c.user.name}</h1>

        <form action='${h.url_for(action='saveProfile')}'>
        <table border="0" cellpadding="4">
            <tr>
                <th>Gravatar</th>
                <td><a href="http://en.gravatar.com/emails"><img class="gravatar-big" src="http://www.gravatar.com/avatar/${c.user.getHashedEmailAddress()}.png" width="80" height="80" /></a></td>
            </tr>
            <tr>
                <th>Id</th>
                <td>${c.user.id}</td>
            </tr>
            <tr>
                <th>${_('Name')}</th>
                <td><input type='text' name='name' value='${c.user.name}' /></td>
            </tr>
            <tr>
                <th>${_('eMail')}</th>
                <td><input type='text' name='email' value='${c.user.email}' /></td>
            </tr>
            <tr>
                <th>${_('OpenId')}</th>
                <td>${c.user.openid}</td>
            </tr>
        </table>
        
        <input type='hidden' name='id' value='${c.user.id}' />
        <input type='submit' value='Save' />
        </form>
</%def>
<%def name="sidenav()">
    
</%def>