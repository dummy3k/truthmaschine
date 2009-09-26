<%!
    from thetruth.lib.markup import renderMarkup, stripMarkupAndTruncate, stripMarkup
    from thetruth.lib.parsedatetime import convertToHumanReadable
%>
<%inherit file="/layout.mako"/>\
<%def name="argumentInput(parentid, istrue)">
<form method="post" action="${h.url_for(controller='statements', action='createNew', istrue=None, id=None)}">
    <input type="hidden" name="argistrue" value="${istrue}" />
    % if parentid:
        <input type="hidden" name="parentid" value="${parentid}" />
    % endif

    <textarea name="msg" id="new-argument">${c.previousMessage}</textarea>
    <input type="submit" value="Submit" />
    
    <span id="characters-left">
        (140 characters left)
    </span>
    
    <br/><br/>
    
    <p class="hint">
        Hint: You can link you text using the following syntax: [http://www.google.de|Google]
    </p>
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
            <td width="40" valign="top">
                <img src="http://www.gravatar.com/avatar/${argument.user.getHashedEmailAddress()}.jpg" width="30" height="30" />
            </td>
            <td valign="top">
                <strong>
                    <a href="${h.url_for(controller='users', action='showProfile', id=argument.user.id)}">
                        ${argument.user.getDisplayName()}
                    </a>
                </strong>
                <br />
                
                ${convertToHumanReadable(argument.created)}
            </td>
            <td width="150" align="right" valign="bottom">
                <a href="${h.url_for(action='show', id=argument.id)}">
                    ${argument.true_count} pro / ${argument.false_count} contra
                </a>
            </td>
        </tr>
    </table>
</div>
</%def>

<%def name="argumentmeta(user, argument = None)">
<div class="argument-meta">
    <a href="${h.url_for(controller='users', action='showProfile', id=user.id)}" 
        class="argument-author">
        
        <img class="gravatar" src="http://www.gravatar.com/avatar/${user.getHashedEmailAddress()}.jpg" />
        ${user.getDisplayName()}
    </a>
    % if argument:
        <span class="argument-timestamp">
            ${argument.created.strftime("%A,&nbsp;%d/%m/%Y&nbsp;%H:%M") | n}
        </span>
    % endif
</div>  
</%def>
    
<%def name="parentthesis(argument)">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td valign="top">
            <p class="small">
                <strong>Parent Thesis:</strong>
            </p>
            <ul class="parent">
                <li>
                    <img src="/img/thesis.jpg" alt="thesis" /> 
                    <a href="${h.url_for(action='show', id=argument.id)}">
                        ${argument.message | stripMarkupAndTruncate}
                    </a>
                </li>
            </ul>
        </td>
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
                    <a href="${h.url_for(controller='votes', action='upvote', id=c.thesis.id)}" 
                        class="voteUpDone"></a>
                % else:
                    <a href="${h.url_for(controller='votes', action='upvote', id=c.thesis.id)}" 
                        class="voteUp"></a>
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
                    <a href="${h.url_for(controller='votes', action='downvote', id=c.thesis.id)}" 
                        class="voteDownDone"></a>
                % else:
                    <a href="${h.url_for(controller='votes', action='downvote', id=c.thesis.id)}" 
                        class="voteDown"></a>
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
            <td width="200" valign="bottom">
                <table width="200" border="0" cellspacing="0" cellpadding="0" class="avatar">
                    <tr>
                        <td width="40" valign="top">
                            <img src="http://www.gravatar.com/avatar/${argument.user.getHashedEmailAddress()}.jpg" 
                                width="30" height="30" />
                        </td>
                        <td valign="top">
                            <strong>
                                <a href="${h.url_for(controller='users', action='showProfile', id=argument.user.id)}">
                                    ${argument.user.getDisplayName()}
                                </a>
                            </strong>
                            <br />
                            ${argument.created.strftime("%A,&nbsp;%d/%m/%Y&nbsp;%H:%M") | n}
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</div>
</%def>
