<%inherit file="/layout.mako"/>\
<%!
    from thetruth.lib.markup import renderMarkup
%>
	
<%def name="main()">
<div class="contraTitle">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="35"><img src="/img/contra.jpg" alt="contra" /></td>
              <td><p>Contra Arguments (${len(c.falseArguments)})</p>
                <p class="login">
% if c.user:
    <a class="small" href="${h.url_for(controller='pages', action='newArgument', id=c.thesis.id, istrue='contra')}">Post a Contra-Argument</a>
% else:
    <a class="small" href="${h.url_for(controller='login', action='signin', id=None)}">Login</a> to post an Contra-Argument
% endif
            	</p></td>
            </tr>
          </table>
          </div>
        <div class="proTitle">
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
              <td width="35"><img src="/img/pro.jpg" /></td>
              <td><p>Pro Arguments (${len(c.trueArguments)})</p>
                <p class="login">
					% if c.user:
					    <a class="small" href="${h.url_for(controller='pages', action='newArgument', id=c.thesis.id, istrue='pro')}">Post a Pro-Argument</a>
					% else:
					    <a class="small" href="${h.url_for(controller='login', action='signin', id=None)}">Login</a> to post an Pro-Argument
					% endif
                </td>
            </tr>
          </table>
          </div>

${self.leftpanel()}
${self.rightpanel()}
</%def>
