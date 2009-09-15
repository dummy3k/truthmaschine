<%inherit file="/layout.mako"/>\
<%!
    from thetruth.lib.markup import renderMarkup
%>

<%def name="thesis()">
	<div class="header">
		<div class="title">
			${self.argumentmeta(c.thesis.user)}		
			<div class="vote vote-true">
			
				<a href="${h.url_for(action='upvote', id=c.thesis.id)}">
			% if c.thesis.is_upvoted_by_user(c.user.id):
				<img src="/img/vote-arrow-up-on.png" />
			% else:
				<img src="/img/vote-arrow-up.png" />
			% endif
				</a>
				<span class="vote-count">${c.thesis.votes}</span>
				<a href="${h.url_for(action='downvote', id=c.thesis.id)}">
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
