<%inherit file="/layout-default.mako"/>\

<%def name="content()">
  <p>
    ${c.message}
  </p>

		<h1>User details for ${c.user.name}</h1>

        <table border=1>
            <tr>
                <td><a href="http://gravatar.com">Gravatar</a></td>
                <td><img class="gravatar-big" src="http://www.gravatar.com/avatar/${c.user.getHashedEmailAddress()}.jpg" /></td>
            </tr>
            <tr>
                <td>Id</td>
                <td>${c.user.id}</td>
            </tr>
            <tr>
                <td>Name</td>
                <td>${c.user.name}</td>
            </tr>
            <tr>
                <td>eMail</td>
                <td>${c.user.email}</td>
            </tr>
            <tr>
                <td>OpenId</td>
                <td>${c.user.openid}</td>
            </tr>
        </table>

</%def>
<%def name="sidenav()">
    
</%def>