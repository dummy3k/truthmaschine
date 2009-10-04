<%inherit file="/users/user-snippets.mako"/>\

<%def name="content()">
	<h1>${_('Search Results for "%s"') % c.query}</h1>

    <table border="0" cellspacing="0" cellpadding="0" class="nicetable">
        <% nr = 0 %>
        % for result in c.results:
            <% nr += 1 %>
            <tr>
                <th>Result ${nr}</th>
                <td>
                    % if result.parentid == None:
                        ${self.thesisOutput(result)}
                    % else:
                        ${self.argumentOutput(result)}
                    % endif    
                </td>
            </tr>
        % endfor
    </table>
</%def>
<%def name="sidenav()">
    
</%def>