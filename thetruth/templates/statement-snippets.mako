<%!
    from thetruth.lib.markup import renderMarkup, stripMarkupAndTruncate, stripMarkup
    from thetruth.lib.parsedatetime import convertToHumanReadable
    from pylons import config
%>
<%inherit file="/layout.mako"/>\
<%def name="argumentInput(parentid, istrue, defaultText, contra)">
<form method="post" action="${h.url_for(controller='statements', action='createNew', istrue=None, id=None)}">
    <input type="hidden" name="argistrue" value="${istrue}" />
    % if parentid:
        <input type="hidden" name="parentid" value="${parentid}" />
    % endif

    <table border="0">
        <tr>
            % if contra:
                <td colspan="2"><textarea name="msg" id="new-argument" class="postContra">${defaultText}</textarea></td>
            % else:
                <td colspan="2"><textarea name="msg" id="new-argument" class="postPro">${defaultText}</textarea></td>
            %endif
        </tr>
        <tr>
            <td>
                <span id="characters-left">
                    ${_('(%s) characters left') % (int(config['statement_length'])-len(defaultText)) | n }
                </span>
            </td>
            <td align="right">
                <input type="submit" value="${_('Submit')}" class="submit" />
            </td>
        </tr>
    </table>
    
    <br/><br/>
    
    <p>
        ${_('<strong>Hint:</strong> You can %s link %s your text using the following syntax: [http://www.google.de|Google].') % ("<a href=\"javascript: link_marked_text()\">", "</a>") | n}
    </p>
    <p>
        ${_('Links do not count into your %s character limit.') % config['statement_length'] }
    </p>
</form>
</%def>
<%def name="topicInput(parentid, istrue, defaultText)">
<form method="post" action="${h.url_for(controller='statements', action='createNew', istrue=None, id=None)}">
    <input type="hidden" name="argistrue" value="${istrue}" />
    % if parentid:
        <input type="hidden" name="parentid" value="${parentid}" />
    % endif

    <table border="0">
        <tr>
            <td colspan="2"><textarea name="msg" id="new-argument">${defaultText}</textarea></td>
        </tr>
        <tr>
            <td>
                <span id="characters-left">
                    ${_('(%s) characters left') % (int(config['statement_length'])-len(defaultText)) | n }
                </span>
            </td>
            <td align="right">
                <input type="submit" value="${_('Submit')}" class="submit" />
            </td>
        </tr>
    </table>
    
    <br/><br/>
    
    <p>
        ${_('<strong>Hint:</strong> You can %s link %s your text using the following syntax: [http://www.google.de|Google].') % ("<a href=\"javascript: link_marked_text()\">", "</a>") | n}
    </p>
    <p>
        ${_('Links do not count into your %s character limit.') % config['statement_length'] }
    </p>
</form>
</%def>
<%def name="argumentEdit(argumentId, defaultText)">
<form method="post" action="${h.url_for(action='post_edit_statement', id=argumentId)}">
    <input type="hidden" name="id" value="${argumentId}" />
           <table border="0">
        <tr>
            <td colspan="2"><textarea name="msg" id="new-argument">${defaultText}</textarea></td>
        </tr>
        <tr>
            <td>
                <span id="characters-left">
                    ${_('(%s) characters left') % (int(config['statement_length'])-len(defaultText)) | n }
                </span>
            </td>
            <td align="right">
                <input type="submit" value="${_('Submit')}" class="submit" />
            </td>
        </tr>
    </table>
    
    <br/>

    <p>
        ${_('<strong>Hint:</strong> You can %s link %s your text using the following syntax: [http://www.google.de|Google].') % ("<a href=\"javascript: link_marked_text()\">", "</a>") | n}
    </p>
    <p>
        ${_('Links do not count into your %s character limit.') % config['statement_length'] }
    </p>
</form>
</%def>
<%def name="argumentOutput(argument)">
% if argument.istrue:
    <div class="pro">
% else:
    <div class="contra">
% endif
	<table border="0" width="100%">
		<tr>
			% if argument.istrue == False:
				<td class="votes"> 
					${argument.votes}
				</td>
			% endif
			<td class="content">
			    <p>${argument.message | n,h,renderMarkup}</p>
			    <br />
			    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="avatar">
			        <tr>
						% if argument.istrue == True:
				            <td width="280" align="left" valign="bottom">
				                <a href="${h.url_for(action='show', id=argument.id)}" class="procontra">
				                    ${_('%s pro / %s contra') % (argument.true_count, argument.false_count)}
				                </a>
				            </td>
						% endif			        	
			        
			        
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
						% if argument.istrue == False:
				            <td width="150" align="right" valign="bottom">
				                <a href="${h.url_for(action='show', id=argument.id)}" class="procontra">
                                    ${_('%s pro / %s contra') % (argument.true_count, argument.false_count)}
				                </a>
				            </td>
						% endif			        	
			        </tr>
			    </table>
			</td>
			% if argument.istrue == True:
				<td class="votes"> 
					${argument.votes}
				</td>
			% endif
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
                <strong>${_('Parent Thesis:')}</strong>
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
                    <a href="${h.url_for(action='edit_statement', id=argument.id)}" class="edit">
                        ${_('edit')}
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
                                <a href="${h.url_for(controller='users', action='showProfile', id=argument.user.id)}" class="normal">
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
