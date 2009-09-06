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
			<a href="index.html">Login</a>
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
			<h1>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed</h1>
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
		
		<div class="left-panel">

${next.body()}\
		
		
			<h1>True</h1>
			<div class="argument">
				<div class="argument-text">	
					<a href="argument.html" class="argument-link">
			Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed
					</a>
				</div>
				<div class="argument-meta">
					<a href="index.html" class="argument-author">Jonny A.</a> <span class="argument-timestamp">2009/09/05 12:12</span>
				</div>
			</div>
			<div class="argument">
				<div class="argument-text">
					<a href="argument.html" class="argument-link">
			Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed
					</a>
				</div>
				<div class="argument-meta">
					<a href="index.html" class="argument-author">Jonny A.</a> <span class="argument-timestamp">2009/09/05 12:12</span>
				</div>
			</div>
			<div class="argument">
				<div class="argument-text">
					<a href="argument.html" class="argument-link">
			Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed
					</a>
				</div>
				<div class="argument-meta">
					<a href="index.html" class="argument-author">Jonny A.</a> <span class="argument-timestamp">2009/09/05 12:12</span>
				</div>
			</div>
		</div>

		<div class="right-panel">

			<h1>False</h1>
			<div class="argument">
				<div class="argument-text">
					<a href="argument.html" class="argument-link">
			Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed
					</a>
				</div>
				<div class="argument-meta">
					<a href="index.html" class="argument-author">Jonny A.</a> <span class="argument-timestamp">2009/09/05 12:12</span>
				</div>
			</div>
			<div class="argument">
				<div class="argument-text">
					<a href="argument.html" class="argument-link">
			Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed
					</a>
				</div>
				<div class="argument-meta">
					<a href="index.html" class="argument-author">Jonny A.</a> <span class="argument-timestamp">2009/09/05 12:12</span>
				</div>
			</div>
			<div class="argument">
				<div class="argument-text">
					<a href="argument.html" class="argument-link">
			Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed
					</a>
				</div>
				<div class="argument-meta">
					<a href="index.html" class="argument-author">Jonny A.</a> <span class="argument-timestamp">2009/09/05 12:12</span>
				</div>
			</div>
		</div>

		<div class="clearer"><span></span></div>
	</div>

	<div class="footer">&copy; 2009 <a href="/">thetruth.gov</a>. Nothing but The Truth  (tm).</div>
</div>
</body>
</html>