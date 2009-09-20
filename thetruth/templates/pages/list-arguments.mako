<%inherit file="/layout-truefalse.mako"/>\

<%def name="leftpanel()">
<p>
% if c.user:
    <a href="${h.url_for(controller='pages', action='newArgument', id=c.thesis.id, istrue='pro')}">Post a Pro-Argument</a>
% else:
    <a href="${h.url_for(controller='login', action='signin')}">Login</a> to post an Pro-Argument
% endif
</p>
% for argument in c.trueArguments:
${self.argumentOutput(argument)}
% endfor
</%def>

<%def name="rightpanel()">
<p>
% if c.user:
    <a href="${h.url_for(controller='pages', action='newArgument', id=c.thesis.id, istrue='contra')}">Post a Conra-Argument</a>
% else:
    <a href="${h.url_for(controller='login', action='signin')}">Login</a> to post an Contra-Argument
% endif
</p>

% for argument in c.falseArguments:
${self.argumentOutput(argument)}
% endfor
</%def>

<%def name="thesisarea()">
    % if c.parentthesis:
        ${self.parentthesis(c.parentthesis)}
    % endif
    ${self.thesis(c.thesis)}
</%def>