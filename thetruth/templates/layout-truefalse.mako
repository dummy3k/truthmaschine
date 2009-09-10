<%inherit file="/layout.mako"/>\


<%def name="argumentmeta(user)">
<div class="argument-meta">
	<a href="index.html" class="argument-author">${user.getDisplayName()}</a> <span class="argument-timestamp">2009/09/05 12:12</span>
</div>	
</%def>
	
<div class="left-panel">
	<h1>True</h1>
	${self.leftpanel()}
</div>

<div class="right-panel">
	<h1>False</h1>
	${self.rightpanel()}
</div>