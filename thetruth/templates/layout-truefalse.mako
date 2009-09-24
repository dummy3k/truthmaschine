<%inherit file="/layout.mako"/>\
<%!
    from thetruth.lib.markup import renderMarkup
%>
	
<%def name="main()">
<div class="left-panel">
	<h1>Pro Arguments</h1>
	${self.leftpanel()}
</div>

<div class="right-panel">
	<h1>Contra Arguments</h1>
	${self.rightpanel()}
</div>
</%def>
