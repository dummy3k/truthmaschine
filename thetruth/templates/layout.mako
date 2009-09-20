<%!
    from thetruth.lib.markup import renderMarkup
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN"
"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>

<head>
	<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
	<meta name="description" content="description"/>
	<meta name="keywords" content="keywords"/> 
	<meta name="author" content="author"/> 
	<title>the Truth (tm)</title>
	${h.stylesheet_link('/default.css')}
    ${h.javascript_link( '/js/jquery-1.3.2.min.js')}
    ${h.javascript_link( '/js/jquery-ui-1.7.2.custom.min.js')}
    ${h.javascript_link( '/script.js')}
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

<%def name="argumentInput(parent_id, istrue)">
  <form method="post" action="${h.url_for(controller='pages', action='createNew')}">
    <textarea name="msg" class="new-argument"></textarea>
    
    % if parent_id:
    <input type="hidden" name="parentid" value="${parent_id}" />
    % endif
    
    % if istrue:
    <input type="hidden" name="istrue" value="${istrue}" />
    % endif
    <input type="submit" value="Submit" />
    <span class="characters-left">(140 chars)</span>
  </form>
</%def>

<%def name="argumentOutput(argument)">
<div class="argument">
	<div class="argument-text">	
        ${argument.message | n,h,renderMarkup}
		<a href="${h.url_for(action='show', id=argument.id)}" class="argument-link">
			more?
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
    
<%def name="thesis()">
<div class="header">
        <div class="title">
            ${self.argumentmeta(c.thesis.user, c.thesis)}        
            <div class="vote vote-true">
            
                <a id="upvote-link" href="${h.url_for(action='upvote', id=c.thesis.id)}">
            % if c.thesis.is_upvoted_by_user(c.user.id):
                <img src="/img/vote-arrow-up-on.png" />
            % else:
                <img src="/img/vote-arrow-up.png" />
            % endif
                </a>
                <span id="vote-count">${c.thesis.votes}</span>
                <a id="downvote-link" href="${h.url_for(action='downvote', id=c.thesis.id)}">
            % if c.thesis.is_downvoted_by_user(c.user.id):
                <img src="/img/vote-arrow-down-on.png" />
            % else:
                <img src="/img/vote-arrow-down.png" />
            % endif
                </a>
            </div>
            <h1>${c.thesis.message | n,h,renderMarkup}</h1>
        </div>

    </div>
</%def>

<%def name="thesisarea()">
</%def>

<%def name="main()">
</%def>
