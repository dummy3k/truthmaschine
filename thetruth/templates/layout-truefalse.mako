<%inherit file="/layout.mako"/>\

<%def name="argumentInput(istrue)">
  <form method="post" action="${h.url_for(action='createNew')}">
    <textarea name="msg"></textarea>
    <input type="hidden" name="parentid" value="${c.thesis.id}" />
    <input type="hidden" name="istrue" value="${istrue}" />
    <input type="submit" value="Submit" />
  </form>
</%def>


<%def name="argumentOutput(argument)">
<div class="argument">
	<div class="argument-text">	
		<a href="${h.url_for(action='show', id=it.id)}" class="argument-link">
			${it.message}
		</a>
	</div>
        
	${self.argumentmeta(it.user)}
</div>
</%def>

<%def name="thesis()">
	<div class="header">
		<div class="title">
			<div class="vote vote-true">
				<a href="${h.url_for(action='upvote', id=c.thesis.id)}"><img src="/img/vote-arrow-up.png" /></a>
				<span class="vote-count">${c.thesis.votes}</span>
				<a href="${h.url_for(action='downvote', id=c.thesis.id)}"><img src="/img/vote-arrow-down.png" /></a>
			</div>
			<h1>${c.thesis.message}</h1>
			${self.argumentmeta(c.thesis.user)}		
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
