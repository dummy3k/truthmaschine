<%inherit file="/layout-default.mako"/>\

<%def name="content()">
    <div class="thesis">
        <h1>Top Thesis: </h1>

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
<h1>What is this all about?</h1>

<p>the truth (tm) is a collaborate web application for finding the truth. </p>
<p>We do so, by <strong>collecting Pro and Contra Arguments, voting them, and digging deeper</strong>.</p> 
<p>Every Argument can be viewed as a Thesis with it's own arguments. Try it!</p>

<h3>And remeber: Be nice! We are all in this together.</h3>

<p>Contribute by creating <a href="${h.url_for(controller='pages', action='new')}">your own Thesis</a>.</p>

</%def>