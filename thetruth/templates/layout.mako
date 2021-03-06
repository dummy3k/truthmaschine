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
        <title>${c.title | stripMarkup} - ${_('truthmachine')}</title>
    %else:
        <title>${_('truthmachine')}</title>
    %endif

	${h.stylesheet_link('/css/default.css')}
    ${h.stylesheet_link('/css/ui-lightness/jquery-ui-1.7.2.custom.css')}
    ${h.javascript_link( '/js/jquery-1.3.2.min.js')}
    ${h.javascript_link( '/js/jquery-ui-1.7.2.custom.min.js')}
    ${h.javascript_link( '/js/urlEncode.js')}
    ${h.javascript_link( '/config.js')}
    ${h.javascript_link( '/js/script.js')}
    
    <link rel="shortcut icon" href="/ico/logo.ico" type="image/x-icon">
    <link rel="alternate" type="application/rss+xml" title="${_('All latest Statements')}" href="${config['base_url']}/latest-rss.xml" />
    
    % for x in c.feeds:
    <link rel="alternate" type="application/rss+xml" title="${x['title']}" href="${x['link']}" />
    % endfor
</head>
<body>

<div id="container">
    <div id="logo">
        <a href="${h.url_for(controller='statements', action='index', id=None, istrue=None)}">
        % if session['lang'] == 'de':
            <img src="/img/logo_de.jpg" alt="truthmachine" />
        % else:
            <img src="/img/logo_en.jpg" alt="truthmachine" />
        % endif 
        </a>
      </div>
      
      <div id="headmenu">
        <p align="right">
            <a href="?language=de">
                % if 'lang' in session and session['lang'] == 'de':
                    <img src="/img/de.png" />
                % else:
                    <img src="/img/de-inactive.png" />
                % endif
            </a>
            
            <a href="?language=en">
                % if 'lang' in session and session['lang'] == 'en':
                    <img src="/img/gb.png" />
                % else:
                    <img src="/img/gb-inactive.png" />
                % endif
            </a> |
        
            <a href="${h.url_for(controller='statements', action='index', id=None)}">${_('All Thesis')}</a> | 
            <a href="${h.url_for(controller='statements', action='newThesis', id=None)}">${_('New Thesis')}</a> | 
            <a href="${h.url_for(controller='pages', action='about', id=None)}">${_('Whats going on?')}</a> | 

            % if c.user:
                <a href="${h.url_for(controller='users', action='showProfile', id=c.user.id)}">
                    ${_('Signed in as')} ${c.user.getDisplayName()}
                </a> |
                
                <a href="${h.url_for(controller='login', action='signout', id=None)}">${_('Logout')}</a>
            % else:
                <a href="${h.url_for(controller='login', action='signin', id=None)}">${_('Login')}</a>
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
                <form action="/search/search" method="get" name="search">
                    <input name="query" type="text" value="${_('Search...')}"  onfocus="document.forms.search.query.value='';" />
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
            <a href="${h.url_for(controller='statements', action='index', id=None)}">${_('truthmachine')}</a>. 
            ${_('user contributed content licensed under %s cc-wiki %s with attribution required') % ("<a href=\"http://creativecommons.org/licenses/by-sa/2.5/\">", "</a>") | n}
            ${_('like %s stackoverflow %s') % ("<a href=\"http://www.stackoverflow.com\">", "</a>") | n}
        </div>
      </div>
  </div>
</body>
</html>

<%def name="main()">
</%def>

