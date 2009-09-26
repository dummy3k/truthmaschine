<%inherit file="/layout-default.mako"/>\

<%def name="content()">
    % if c.previousMessage:
        ${self.argumentEdit(c.statement.id, c.previousMessage)}
    % else:
        ${self.argumentEdit(c.statement.id, c.statement.message)}
    % endif
</%def>
<%def name="sidenav()">
</%def>

<%def name="thesisarea()">
    % if c.parentthesis:
        ${self.parentthesis(c.parentthesis)}
    % endif
    % if c.thesis:
        ${self.thesis(c.thesis)}
    % endif
</%def>