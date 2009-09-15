<%inherit file="/layout.mako"/>\

<%def name="main()">
<div class="content">
	${self.content()}
</div>

<div class="sidenav">
	${self.sidenav()}
</div>
</%def>