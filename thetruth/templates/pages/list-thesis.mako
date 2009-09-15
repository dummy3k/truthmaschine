<%inherit file="/layout-default.mako"/>\

<%def name="content()">
    <div class="thesis">
        <h1>List of all Thesis</h1>

        % for it in c.thesis:
            ${self.argumentOutput(it)}
        % endfor

        
        % if len(c.thesis) == 0: 
        <p class="error">
            Sorry, no thesis found. Please <a href="${h.url_for(controller='pages', action='new')}">create one</a>.
        </p>
        % endif
    </div>
</%def>

<%def name="sidenav()">
<h1>Create a new Thesis</h1>

<p>Please contribute by creating your own <a href="${h.url_for(controller='pages', action='new')}">Thesis</a></p>

</%def>