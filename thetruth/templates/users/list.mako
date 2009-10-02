<%inherit file="/layout-default.mako"/>\

<%def name="content()">
<h1>${_('User list')}</h1>

<table border=1>
    <tr>
        <td>Id</td>
        <td>${_('Name')}</td>
        <td>${_('eMail')}</td>
        <td>${_('OpenId')}</td>
        <td>${_('<i>Operations</i>')}</td>
    </tr>

    % for user in c.users:
    <tr>
        <td>${user.id}</td>
        <td>${user.name}</td>
        <td>${user.email}</td>
        <td>${user.openid}</td>
        <td>
            <a href='${h.url_for(action='showProfile', id=user.id)}'>${_('Show')}</a>&nbsp;
            <a href='${h.url_for(action='Delete')}'>${_('Delete')}</a>
       </td>
    </tr>
    %endfor

</%def>
<%def name="sidenav()">
    
</%def>