<%inherit file="/layout-truefalse.mako"/>\

<%def name="leftpanel()">
${self.argumentInput('true')}
% for argument in c.trueArguments:
${self.argumentOutput(argument)}
% endfor
</%def>

<%def name="rightpanel()">
${self.argumentInput('false')}
% for argument in c.falseArguments:
${self.argumentOutput(argument)}
% endfor
</%def>
