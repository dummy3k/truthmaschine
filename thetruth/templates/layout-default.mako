<%inherit file="/layout.mako"/>\

<%def name="main()">
<table border="0" cellspacing="0" cellpadding="0">
<tr><td>
<div class="main">
	${self.content()}
</div>
</td><td>

<div class="sidenav">
	${self.sidenav()}
</div>
</td></tr>
</table>
</%def>