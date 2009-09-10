<%inherit file="/layout-truefalse.mako"/>\

<%def name="argumentInput(istrue)">
  <form method="post" action="${h.url_for(action='createNew')}">
    <textarea name="msg"></textarea>
    <input type="hidden" name="parentid" value="${c.thesis.id}" />
    <input type="hidden" name="istrue" value="${istrue}" />
    <input type="submit" value="Submit" />
  </form>
</%def>


<%def name="argumentOutput(arguments)">
% for it in arguments:
<div class="argument">
	<div class="argument-text">	
		<a href="${h.url_for(action='show', id=it.id)}" class="argument-link">
			${it.message}
		</a>
	</div>
	<div class="argument-meta">
		<a href="index.html" class="argument-author">${it.user.getDisplayName()}</a> <span class="argument-timestamp">2009/09/05 12:12</span>
	</div>
</div>
% endfor
</%def>

<%def name="leftpanel()">
${self.argumentInput('true')}
${self.argumentOutput(c.trueArguments)}
</%def>
<%def name="rightpanel()">
${self.argumentInput('false')}
${self.argumentOutput(c.falseArguments)}
</%def>
