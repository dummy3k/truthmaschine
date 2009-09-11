<%inherit file="/layout-default.mako"/>\

<%def name="content()">
<div class="thesis">
hallo


	% for it in c.thesis:
	<div class="thesis">	
		<a href="${h.url_for(action='show', id=it.id)}" class="argument-link">
			message: ${it.message}
		</a>
	</div>
	% endfor
</div>
</%def>
<%def name="sidenav()">
<div class="argument">
	
</div>
</%def>
