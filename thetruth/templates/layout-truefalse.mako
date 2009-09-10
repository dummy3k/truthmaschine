<%inherit file="/layout.mako"/>\

<%def name="thesis()">
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
			<h1>${c.thesis.message}</h1>
			<div class="argument-meta">
				<a href="index.html" class="argument-author">Jonny A.</a> <span class="argument-timestamp">2009/09/05 12:12</span>
			</div>			
		</div>

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