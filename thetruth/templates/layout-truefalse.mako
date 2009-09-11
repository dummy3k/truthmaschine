<%inherit file="/layout.mako"/>\

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

<%def name="thesis()">
	<div class="header">
		<div class="title">
			${self.argumentmeta(c.thesis.user)}		
			<div class="vote vote-true">
				<a href="${h.url_for(action='upvote', id=c.thesis.id)}"><img src="/img/vote-arrow-up.png" /></a>
				<span class="vote-count">${c.thesis.votes}</span>
				<a href="${h.url_for(action='downvote', id=c.thesis.id)}"><img src="/img/vote-arrow-down.png" /></a>
			</div>
			<h1>${c.thesis.message}</h1>
		</div>

	</div>
</%def>

<%def name="argumentmeta(user)">
<div class="argument-meta">
	<a href="index.html" class="argument-author">${user.getDisplayName()}</a> <span class="argument-timestamp">2009/09/05 12:12</span>
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
