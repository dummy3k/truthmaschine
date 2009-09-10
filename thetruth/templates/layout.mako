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
			<a href="index.html">New Thesis</a>
			<a href="index.html">What's going on?</a>
            
            % if c.user:
            Signed in as ${c.user.openid}
			<a href="${h.url_for(controller='login', action='signout')}">Logout</a>
            % else:
			<a href="${h.url_for(controller='login', action='signin')}">Login</a>
            % endif
            
			<div class="clearer"><span></span></div>
		</div>

	<div class="header">
				
		<div class="title">
			<div class="vote vote-true">
				<img src="img/vote-arrow-up.png" />
				<span class="vote-count">2</span>
				<img src="img/vote-arrow-down.png" />
			</div>
			<div class="vote vote-false">
				<img src="img/vote-arrow-up.png" />
				<span class="vote-count">99</span>
				<img src="img/vote-arrow-down.png" />
			</div>
			<h1>${c.statementText}</h1>
			<div class="argument-meta">
				<a href="index.html" class="argument-author">Jonny A.</a> <span class="argument-timestamp">2009/09/05 12:12</span>
			</div>			
		</div>

	</div>
<% flashes = h.flash.pop_messages() %>
% if flashes:
% for flash in flashes:
<div id="flash">
  <span class="message">${flash}</span>
</div>
% endfor
% endif


	<div class="main">		
${next.body()}\

		<div class="clearer"><span></span></div>
	</div>

	<div class="footer">&copy; 2009 <a href="/">thetruth.gov</a>. Nothing but The Truth  (tm).</div>
</div>
</body>
</html>