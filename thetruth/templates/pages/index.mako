<%inherit file="/base.mako"/>\

<%def name="header()">Title List</%def>

${h.secure_form(url('delete_page'))}
test
${h.end_form()}
