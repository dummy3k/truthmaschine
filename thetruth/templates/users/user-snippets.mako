<%inherit file="/layout-default.mako"/>\

<%def name="showRecentStatements(user)">
    <h1>${_('Latest Statements')}</h1>
    
    <div class="latest-user-statements">
        % for statement in user.get_latest_statements(10):
            ${self.thesisOutput(statement)}
        % endfor
    </div>
</%def>
