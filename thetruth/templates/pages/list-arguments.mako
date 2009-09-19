<%inherit file="/layout-truefalse.mako"/>\

<%def name="leftpanel()">
% if c.user:
    <a href="${h.url_for(controller='pages', action='newArgument', id=c.thesis.id, istrue='pro')}">Post a Pro Argument</a>
% else:
    <a href="${h.url_for(controller='login', action='signin')}">Login</a> to post an Argument
% endif

% for argument in c.trueArguments:
${self.argumentOutput(argument)}
% endfor
</%def>

<%def name="rightpanel()">
% if c.user:
    <a href="${h.url_for(controller='pages', action='newArgument', id=c.thesis.id, istrue='contra')}">Post a Konra Argument</a>
% else:
    <a href="${h.url_for(controller='login', action='signin')}">Login</a> to post an Argument
% endif

% for argument in c.falseArguments:
${self.argumentOutput(argument)}
% endfor
</%def>


<%def name="thesisarea()">
    ${self.thesis()}
</%def>