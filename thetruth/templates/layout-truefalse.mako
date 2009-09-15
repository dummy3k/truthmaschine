<%inherit file="/layout.mako"/>\

<%def name="thesis()">
	<div class="header">
		<div class="title">
			${self.argumentmeta(c.thesis.user)}		
			<div class="vote vote-true">
				<a href="${h.url_for(action='upvote', id=c.thesis.id)}"><img src="/img/vote-arrow-up.png" /></a>
				<span class="vote-count">${c.thesis.votes}</span>
				<a href="${h.url_for(action='downvote', id=c.thesis.id)}"><img src="/img/vote-arrow-down.png" /></a>
			</div>
			<h1>${c.thesis.renderMessage() | n}</h1>
		</div>

	</div>
</%def>
	
<%def name="main()">
<div class="left-panel">
	<h1>True</h1>
	${self.leftpanel()}
</div>

<div class="right-panel">
	<h1>False</h1>
	${self.rightpanel()}
</div>
</%def>
