<html>
	<body>
		<h1>User list</h1>

        ${h.url_for(controller='hello', action='sayHello')}
        
        <pre>
        ${c.users}
        <pre>
        <table border=1>
            <tr>
                <td>Id</td>
                <td>Name</td>
                <td>eMail</td>
                <td>OpenId</td>
            </tr>

            % for user in c.users:
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.openid}</td>
            </tr>
            %endfor
        </table>
    </body>
</html>
