<%inherit file="/layout.mako"/>\

<%def name="main()">
<table border="0" cellspacing="0" cellpadding="0">
<tr><td valign="top">
<div class="main">
	${self.content()}
</div>
</td><td valign="top">

<div class="sidenav">
	${self.sidenav()}
</div>
</td></tr>
</table>
</%def>