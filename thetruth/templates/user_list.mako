<html>
	<body>
		<h1>User list</h1>

        
        <form action='${h.url_for(action='add')}'>
            Add User: <input type=text name='name' /> <input type=submit />
        </form>
        <table border=1>
            <tr>
                <td>Id</td>
                <td>Name</td>
                <td>eMail</td>
                <td>OpenId</td>
                <td><i>Operations</i></td>
            </tr>

            % for user in c.users:
            <tr>
                <td>${user.id}</td>
                <td>${user.name}</td>
                <td>${user.email}</td>
                <td>${user.openid}</td>
                <td>
                    <a href = '${h.url_for(action='showDetails', id=user.id)}'>Show</a>&nbsp;
                    <a href = '${h.url_for(action='Delete')}'>Delete</a>
               </td>
            </tr>
            %endfor
        </table>
        ##<p>${c.users}</p>
        ##<-- ${h.url_for(controller='hello', action='sayHello')} -->
    </body>
</html>
