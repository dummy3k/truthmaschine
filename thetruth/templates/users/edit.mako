<html>
	<body>
		<h1>User details for ${c.user.name}</h1>

        <form action = '${h.url_for(action='saveProfile')}'>
        <table border=1>
            <tr>
                <td>Name</td>
                <td><input type='text' name='name' value='${c.user.name}' /></td>
            </tr>
            <tr>
                <td>eMail</td>
                <td><input type='text' name='email' value='${c.user.email}' /></td>
            </tr>
            <tr>
                <td>OpenId</td>
                <td>${c.user.openid}</td>
            </tr>
        </table>
        <input type='hidden' name='id' value='${c.user.id}' />
        <input type='submit' value='Save' />
        <form>
    </body>
</html>
