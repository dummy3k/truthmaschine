<%inherit file="/layout-truefalse.mako"/>\

<%def name="leftpanel()">
% if c.user:
${self.argumentInput(c.thesis.id,'true')}
% else:
    <a href="${h.url_for(controller='login', action='signin')}">Login</a> to post an Argument
% endif

% for argument in c.trueArguments:
${self.argumentOutput(argument)}
% endfor
</%def>

<%def name="rightpanel()">
% if c.user:
${self.argumentInput(c.thesis.id,'false')}
% else:
    <a href="${h.url_for(controller='login', action='signin')}">Login</a> to post an Argument
% endif

% for argument in c.falseArguments:
${self.argumentOutput(argument)}
% endfor
</%def>
