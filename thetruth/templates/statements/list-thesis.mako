<%inherit file="/layout-default.mako"/>\

<%def name="content()">
    <div class="thesis">
        <h1>${_('Top Thesis: ')}</h1>

        % for it in c.thesis:        
            ${self.thesisOutput(it)}
        % endfor
        
        % if len(c.thesis) == 0: 
        <p class="error">
            ${_('Sorry, no thesis found. Please %s create one %s .') % ( "<a href=\"" + h.url_for(controller='statements', action='newThesis') + "\">", "</a>") | n}
        </p>
        % endif
    </div>
</%def>

<%def name="sidenav()">
<h1>${_('What is this all about?')}</h1>

<p>${_('the truth (tm) is a collaborate web application for finding the truth. ') | n}</p>
<p>${_('We do so, by <strong>collecting Pro and Contra Arguments, voting them, and digging deeper</strong>.') | n}</p> 
<p>${_('Every Argument can be viewed as a Thesis with its own arguments. Try it!') | n}</p>

<h3>${_('And remeber: Be nice! We are all in this together.') | n}</h3>

<p>${_('Contribute by creating %s your own Thesis%s.') % ("<a href=\"" + h.url_for(controller='statements', action='newThesis') + "\">", "</a>") | n}</p>

</%def>