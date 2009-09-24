<%!
    from thetruth.lib.markup import renderMarkup, stripMarkupAndTruncate, stripMarkup
    from thetruth.lib.parsedatetime import convertToHumanReadable
%>
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
    ${h.javascript_link( '/js/script.js')}
    ${h.javascript_link( '/script.js')}
    <link rel="shortcut icon" href="ico/logo.ico" type="image/x-icon">
    <link rel="alternate" type="application/rss+xml" title="All latest Statements" href="${config['base_url']}/latest-rss.xml" />
    % for x in c.feeds:
    <link rel="alternate" type="application/rss+xml" title="${x['title']}" href="${x['link']}" />
    % endfor
</head>
<body>

<div id="container">
      <div id="logo">
        <a href="${h.url_for(controller='pages', action='index', id=None)}">
            <img src="/img/logo.jpg" alt="truthmachine" />
        </a>
      </div>
      <div id="headmenu">
        <p align="right">
            <a href="${h.url_for(controller='pages', action='index', id=None)}">All Thesis</a> | 
            <a href="${h.url_for(controller='pages', action='newThesis', id=None)}">New Thesis</a> | 
            <a href="${h.url_for(controller='pages', action='about', id=None)}">What's going on?</a> | 

            % if c.user:
                <a href="${h.url_for(controller='users', action='showProfile', id=c.user.id)}">Signed in as ${c.user.getDisplayName()}</a> |
                <a href="${h.url_for(controller='login', action='signout', id=None)}">Logout</a>
            % else:
                <a href="${h.url_for(controller='login', action='signin', id=None)}">Login</a>
            % endif
        </p>
  </div>

  <div id="search">
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="25"><img src="/img/search.jpg" alt="search" width="20" height="20" /></td>
          <td><form action="" method="get" name="search"><input name="input" type="text" value="Search..."  onfocus="document.forms.search.input.value='';" />  </form> </td>
        </tr>
      </table>
  </div>

		
<% flashes = h.flash.pop_messages() %>
% if flashes:
    % for flash in flashes:
    <div id="flash">
      <span class="message">${flash}</span>
    </div>
    % endfor
% endif


      <div id="mainContent" onclick="document.forms.search.input.value='Search...';">
        ${self.thesisarea()}
        ${self.main()}

        <div id="footer">
        <a href="${h.url_for(controller='pages', action='index', id=None)}">truthmachine</a>. user contributed content licensed under <a href="http://creativecommons.org/licenses/by-sa/2.5/">cc-wiki</a> with <a href="http://blog.stackoverflow.com/2009/06/attribution-required/">attribution required</a> like <a href="http://www.stackoverflow.com">stackoverflow</a>
        </div>
      </div>
  </div>
</body>
</html>

<%def name="argumentInput(parentid, istrue)">
  <form method="post" action="${h.url_for(controller='pages', action='createNew', istrue=None, id=None)}">
    <textarea name="msg" id="new-argument">${c.previousMessage}</textarea>
    
    % if parentid:
    <input type="hidden" name="parentid" value="${parentid}" />
    % endif
    
    <input type="hidden" name="argistrue" value="${istrue}" />
    
    <input type="submit" value="Submit" />
    <span id="characters-left">(140 characters left)</span>
    <br/><br/>
    <p class="hint">Hint: You can link you text using the following syntax: [http://www.google.de|Google]</p>
  </form>
</%def>

<%def name="argumentOutput(argument)">
% if argument.istrue:
<div class="pro">
% else:
<div class="contra">
% endif
  <p>${argument.message | n,h,renderMarkup}</p>
  <br />
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="avatar">
    <tr>
      <td width="40" valign="top"><img src="http://www.gravatar.com/avatar/${argument.user.getHashedEmailAddress()}.jpg" width="30" height="30" /></td>
      <td valign="top"><strong><a href="${h.url_for(controller='users', action='showProfile', id=argument.user.id)}">${argument.user.getDisplayName()}</a></strong><br />
        ${convertToHumanReadable(argument.created)}</td>
      <td width="150" align="right" valign="bottom"><a href="${h.url_for(action='show', id=argument.id)}">${argument.true_count} pro / ${argument.false_count} contra</a></td>
    </tr>
  </table>
</div>
</%def>

<%def name="argumentmeta(user, argument = None)">
<div class="argument-meta">
	<a href="${h.url_for(controller='users', action='showProfile', id=user.id)}" class="argument-author">
	    <img class="gravatar" src="http://www.gravatar.com/avatar/${user.getHashedEmailAddress()}.jpg" />
	    ${user.getDisplayName()}
    </a>
    % if argument:
    <span class="argument-timestamp">${argument.created.strftime("%A,&nbsp;%d/%m/%Y&nbsp;%H:%M") | n}</span>
    % endif
</div>	
</%def>
    
<%def name="parentthesis(argument)">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td valign="top">
    <p class="small"><strong>Parent Thesis:</strong></p>
       <ul class="parent">
       <li><img src="/img/thesis.jpg" alt="thesis" /> <a href="${h.url_for(action='show', id=argument.id)}">${argument.message | stripMarkupAndTruncate}</a></li>
       </ul></td>
    <td width="200" valign="top">&nbsp;</td>
  </tr>
</table>
</%def>

<%def name="thesis(argument)">
<div class="vote">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
        % if c.user:
          <tr>
            <td><div align="center">
                % if argument.is_upvoted_by_user(c.user.id):
                <a href="${h.url_for(action='upvote', id=c.thesis.id)}" class="voteUpDone"></a>
                % else:
                <a href="${h.url_for(action='upvote', id=c.thesis.id)}" class="voteUp"></a>
                % endif
            </div></td>
          </tr>
        % endif

      <tr>
        <td><div align="center">${argument.votes}</div></td>
      </tr>

        % if c.user:
          <tr>
            <td><div align="center">
                % if argument.is_downvoted_by_user(c.user.id):
                <a href="${h.url_for(action='downvote', id=c.thesis.id)}" class="voteDownDone"></a>
                % else:
                <a href="${h.url_for(action='downvote', id=c.thesis.id)}" class="voteDown"></a>
                % endif
            </div></td>
          </tr>
        % endif
    </table>
</div>
<div class="title">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td valign="top">
        ${argument.message | n,h,renderMarkup} 


            % if c.user and c.user.allow_edit(argument):
            <p>
                <a href="${h.url_for(action='edit_statement', id=argument.id)}">
                    edit
                </a>
            </p>
            % endif      
      </td>
      <td width="200" valign="bottom"><table width="200" border="0" cellspacing="0" cellpadding="0" class="avatar">
        <tr>
          <td width="40" valign="top"><img src="http://www.gravatar.com/avatar/${argument.user.getHashedEmailAddress()}.jpg" width="30" height="30" /></td>
          <td valign="top"><strong><a href="${h.url_for(controller='users', action='showProfile', id=argument.user.id)}">${argument.user.getDisplayName()}</a></strong><br />
          ${argument.created.strftime("%A,&nbsp;%d/%m/%Y&nbsp;%H:%M") | n}</td>
        </tr>
      </table></td>
    </tr>
  </table>
</div>
</%def>

<%def name="thesisarea()">
</%def>

<%def name="main()">
</%def>
