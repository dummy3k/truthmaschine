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
        
	${self.argumentmeta(it.user)}
</div>
% endfor
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

<%def name="leftpanel()">
${self.argumentInput('true')}
${self.argumentOutput(c.trueArguments)}
</%def>
<%def name="rightpanel()">
${self.argumentInput('false')}
${self.argumentOutput(c.falseArguments)}
</%def>
