<%!
    from thetruth.lib.markup import renderMarkup
    from thetruth.lib.markup import stripMarkupAndTruncate
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<meta name="description" content="description"/>
	<meta name="keywords" content="keywords"/> 
	<meta name="author" content="author"/> 
	%if c.title:
	<title>${c.title} - the Truth (tm)</title>
	%else:
	<title>the Truth (tm)</title>
	%endif
	${h.stylesheet_link('/default.css')}
    ${h.javascript_link( '/js/jquery-1.3.2.min.js')}
    ${h.javascript_link( '/js/jquery-ui-1.7.2.custom.min.js')}
    ${h.javascript_link( '/script.js')}
    <link rel="alternate" type="application/rss+xml" title="Latest Statements RSS-Feed" href="${config['base_url']}/latest-rss.xml" />
</head>
<body>
<div class="container">
	<div class="navigation">
	<a href="${h.url_for(controller='pages', action='index', id=None)}">All Thesis</a>
	<a href="${h.url_for(controller='pages', action='newThesis', id=None)}">New Thesis</a>
	<a href="${h.url_for(controller='pages', action='about', id=None)}">What's going on?</a>
            
            % if c.user:
            <a href="${h.url_for(controller='users', action='showProfile', id=c.user.id)}">Signed in as ${c.user.getDisplayName()}</a>
			         <a href="${h.url_for(controller='login', action='signout', id=None)}">Logout</a>
            % else:
			         <a href="${h.url_for(controller='login', action='signin', id=None)}">Login</a>
            % endif
            
			<div class="clearer"><span></span></div>
		</div>

	${self.thesisarea()}
		
<% flashes = h.flash.pop_messages() %>
% if flashes:
% for flash in flashes:
<div id="flash">
  <span class="message">${flash}</span>
</div>
% endfor
% endif


	<div class="main">		
        ${self.main()}

		<div class="clearer"><span></span></div>
	</div>

	<div class="footer"><a href="${h.url_for(controller='pages', action='index', id=None)}">thetruth</a> (tm) 2009. user contributed content licensed under <a href="http://creativecommons.org/licenses/by-sa/2.5/">cc-wiki</a> with <a href="http://blog.stackoverflow.com/2009/06/attribution-required/">attribution required</a> like <a href="http://www.stackoverflow.com">stackoverflow</a></div>
</div>
</body>
</html>

<%def name="argumentInput(parentid, istrue)">
  <form method="post" action="${h.url_for(controller='pages', action='createNew', istrue=None, id=None)}">
    <textarea name="msg" id="new-argument"></textarea>
    
    % if parentid:
    <input type="hidden" name="parentid" value="${parentid}" />
    % endif
    
    <input type="hidden" name="argistrue" value="${istrue}" />
    
    <input type="submit" value="Submit" />
    <span id="characters-left">(140 characters left)</span>
    <br/>
    <p class="hint">Hint: You can link you text using the following syntax: [http://www.google.de|Google]</p>
  </form>
</%def>

<%def name="argumentOutput(argument)">
<div class="argument">
	<div class="argument-text">	
        ${argument.message | n,h,renderMarkup}
		<a href="${h.url_for(action='show', id=argument.id)}" class="argument-link">
            ${argument.true_count} pro / ${argument.false_count} contra
		</a>
        
	</div>
        
	${self.argumentmeta(argument.user, argument)}
</div>
</%def>

<%def name="argumentmeta(user, argument = None)">
<div class="argument-meta">
	<a href="${h.url_for(controller='users', action='showProfile', id=user.id)}" class="argument-author">
	    <img class="gravatar" src="http://www.gravatar.com/avatar/${user.getHashedEmailAddress()}.jpg" />
	    ${user.getDisplayName()}
    </a>
    % if argument:
    <span class="argument-timestamp">${argument.created.strftime("%A,&nbsp;%d/%m/%Y&nbsp;%H:%M") | n}</span>
    % endif
</div>	
</%def>
    
<%def name="parentthesis(argument)">
<div class="parent-thesis">
        <div class="title">
            <span id="parent-thesis-text">
                Parent Thesis: <a href="${h.url_for(action='show', id=argument.id)}">${argument.message | n,h,stripMarkupAndTruncate}</a>
            </span>
        </div>

    </div>
</%def>
<%def name="thesis(argument)">
<div class="header">
        <div class="title">
            ${self.argumentmeta(argument.user, argument)}        
            <div class="vote vote-true">
            
            % if c.user:
                <a id="upvote-link" href="${h.url_for(action='upvote', id=c.thesis.id)}">
                % if argument.is_upvoted_by_user(c.user.id):
                    <img src="/img/vote-arrow-up-on.png" />
                % else:
                    <img src="/img/vote-arrow-up.png" />
                % endif
                </a>
            % endif
                <span id="vote-count">${argument.votes}</span>
            % if c.user:
                <a id="downvote-link" href="${h.url_for(action='downvote', id=c.thesis.id)}">
                % if argument.is_downvoted_by_user(c.user.id):
                    <img src="/img/vote-arrow-down-on.png" />
                % else:
                    <a id="downvote-link" href="${h.url_for(action='downvote', id=c.thesis.id)}">
                    <img src="/img/vote-arrow-down.png" />
                % endif
                </a>
            % endif
            </div>
            <h1>${argument.message | n,h,renderMarkup}</h1>
            % if c.user and c.user.allow_edit(argument):
            <a href="${h.url_for(action='edit_statement', id=argument.id)}" style="background-color:white">edit</a>
            % endif
        </div>

    </div>
</%def>

<%def name="thesisarea()">
</%def>

<%def name="main()">
</%def>
