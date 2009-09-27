<%inherit file="/layout-default.mako"/>\

<%def name="content()">
    <div class="thesis">
        <h1>${_('Top Thesis: ')}</h1>

        % for it in c.thesis:
            <% 
            if it.votes >= 0:
                it.istrue = True
            else:
                it.istrue = False
            %>
        
            ${self.argumentOutput(it)}
        % endfor
        
        % if len(c.thesis) == 0: 
        <p class="error">
            Sorry, no thesis found. Please <a href="${h.url_for(controller='statements', action='newThesis')}">create one</a>.
        </p>
        % endif
    </div>
</%def>

<%def name="sidenav()">
<h1>${_('What is this all about?')}</h1>

<p>${_('the truth (tm) is a collaborate web application for finding the truth. ')}</p>
<p>${_('We do so, by <strong>collecting Pro and Contra Arguments, voting them, and digging deeper</strong>.')}</p> 
<p>${_('Every Argument can be viewed as a Thesis with its own arguments. Try it!')}</p>

<h3>${_('And remeber: Be nice! We are all in this together.')}</h3>

<p>Contribute by creating <a href="${h.url_for(controller='statements', action='newThesis')}" class="big">your own Thesis</a>.</p>

</%def>