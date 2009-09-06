<html>
	<body>
		<h1>User details for ${c.user.name}</h1>

        <table border=1>
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
    </body>
</html>
