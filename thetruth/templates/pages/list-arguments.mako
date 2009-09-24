<%inherit file="/layout-truefalse.mako"/>\

<%def name="leftpanel()">
<div class="left">
% for argument in c.falseArguments:
${self.argumentOutput(argument)}
% endfor
</div>
</%def>

<%def name="rightpanel()">
<div class="right">
% for argument in c.trueArguments:
${self.argumentOutput(argument)}
% endfor
</div>
</%def>

<%def name="thesisarea()">
    % if c.parentthesis:
        ${self.parentthesis(c.parentthesis)}
    % endif
    ${self.thesis(c.thesis)}
</%def>