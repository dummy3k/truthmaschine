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
</head>
<body>
<div class="container">
	<div class="navigation">
	<a href="${h.url_for(controller='pages', action='index')}">All Thesis</a>
	<a href="${h.url_for(controller='pages', action='new')}">New Thesis</a>
	<a href="${h.url_for(controller='pages', action='about')}">What's going on?</a>
            
            % if c.user:
            Signed in as ${c.user.openid}
			<a href="${h.url_for(controller='login', action='signout')}">Logout</a>
            % else:
			<a href="${h.url_for(controller='login', action='signin')}">Login</a>
            % endif
            
			<div class="clearer"><span></span></div>
		</div>

	${self.thesis()}
		
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

	<div class="footer">&copy; 2009 <a href="/">thetruth.gov</a>. Nothing but The Truth  (tm).</div>
</div>
</body>
</html>

<%def name="argumentInput(parent_id, istrue)">
  <form method="post" action="${h.url_for(action='createNew')}">
    <textarea name="msg" class="new-argument"></textarea>
    
    % if parent_id:
    <input type="hidden" name="parentid" value="${parent_id}" />
    % endif
    
    % if istrue:
    <input type="hidden" name="istrue" value="${istrue}" />
    % endif
    <input type="submit" value="Submit" />
    <p>(140 chars)</p>
  </form>
</%def>

<%def name="argumentOutput(argument)">
<div class="argument">
	<div class="argument-text">	
		<a href="${h.url_for(action='show', id=argument.id)}" class="argument-link">
			${argument.message}
		</a>
	</div>
        
	${self.argumentmeta(argument.user)}
</div>
</%def>

<%def name="argumentmeta(user)">
<div class="argument-meta">
	<a href="index.html" class="argument-author"><img class="gravatar" src="http://www.gravatar.com/avatar/${user.getHashedEmailAddress()}.jpg" />${user.getDisplayName()}</a> <span class="argument-timestamp">2009/09/05 12:12</span>
</div>	
</%def>
    
<%def name="thesis()">
</%def>
<%def name="main()">
</%def>