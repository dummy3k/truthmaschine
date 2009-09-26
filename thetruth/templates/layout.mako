<%!
    from thetruth.lib.markup import renderMarkup, stripMarkupAndTruncate, stripMarkup
    from thetruth.lib.parsedatetime import convertToHumanReadable
%>
<% flashes = h.flash.pop_messages() %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    %if c.title:
        <title>${c.title | stripMarkup} - truthmachine</title>
    %else:
        <title>truthmachine</title>
    %endif

	${h.stylesheet_link('/css/default.css')}
    ${h.stylesheet_link('/css/ui-lightness/jquery-ui-1.7.2.custom.css')}
    ${h.javascript_link( '/js/jquery-1.3.2.min.js')}
    ${h.javascript_link( '/js/jquery-ui-1.7.2.custom.min.js')}
    ${h.javascript_link( '/config.js')}
    ${h.javascript_link( '/js/script.js')}
    
    <link rel="shortcut icon" href="/ico/logo.ico" type="image/x-icon">
    <link rel="alternate" type="application/rss+xml" title="All latest Statements" href="${config['base_url']}/latest-rss.xml" />
    
    % for x in c.feeds:
    <link rel="alternate" type="application/rss+xml" title="${x['title']}" href="${x['link']}" />
    % endfor
</head>
<body>

<div id="container">
    <div id="logo">
        <a href="${h.url_for(controller='statements', action='index')}">
            <img src="/img/logo.jpg" alt="truthmachine" />
        </a>
      </div>
      
      <div id="headmenu">
        <p align="right">
            <a href="${h.url_for(controller='statements', action='index', id=None)}">All Thesis</a> | 
            <a href="${h.url_for(controller='statements', action='newThesis', id=None)}">New Thesis</a> | 
            <a href="${h.url_for(controller='pages', action='about', id=None)}">What's going on?</a> | 

            % if c.user:
                <a href="${h.url_for(controller='users', action='showProfile', id=c.user.id)}">
                    Signed in as ${c.user.getDisplayName()}
                </a> |
                
                <a href="${h.url_for(controller='login', action='signout', id=None)}">Logout</a>
            % else:
                <a href="${h.url_for(controller='login', action='signin', id=None)}">Login</a>
            % endif
        </p>
    </div>

    <div id="search">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr>
                <td width="25">
                    <img src="/img/search.jpg" alt="search" width="20" height="20" />
                </td>
                <td>
                <form action="" method="get" name="search">
                    <input name="input" type="text" value="Search..."  onfocus="document.forms.search.input.value='';" />
                </form>
                </td>
            </tr>
        </table>
    </div>
		
% if flashes:
    % for flash in flashes:
        <div class="ui-state-highlight ui-corner-all">
            <span class="ui-icon ui-icon-info">&nbsp;</span>
            <span class="flash-text">${flash}</span>
        </div>
    % endfor
% endif


      <div id="mainContent" onclick="document.forms.search.input.value='Search...';">
        ${self.main()}

        <div id="footer">
        <a href="${h.url_for(controller='statements', action='index', id=None)}">truthmachine</a>. user contributed content licensed under <a href="http://creativecommons.org/licenses/by-sa/2.5/">cc-wiki</a> with <a href="http://blog.stackoverflow.com/2009/06/attribution-required/">attribution required</a> like <a href="http://www.stackoverflow.com">stackoverflow</a>
        </div>
      </div>
  </div>
</body>
</html>

<%def name="main()">
</%def>

