<%inherit file="/layout-default.mako"/>\

<%def name="showRecentStatements(user)">
    <h1>${_('Latest Statements')}</h1>
    
    <div class="latest-user-statements">
        % for statement in user.get_latest_statements(10):
            ${self.thesisOutput(statement)}
        % endfor
    </div>
</%def>

<%def name="showUserVotes(user)">
    <h1>${_('User Vote Count')}</h1>

${user.attach_vote_count()}
<div class="vote">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td>
			<div align="center">
				<span class="voteUpDone">&nbsp;</span>
			</div>
		</td>
		<td><div align="left"><nobr> ${user.upvote_count} ${_('Upvotes')}</nobr></div></td>
	  </tr>
	  <tr>
		<td>
			<div align="center">
				<span class="voteDownDone">&nbsp;</span>
			</div>
		</td>
		<td><div align="left"><nobr> ${user.downvote_count} ${_('Downvotes')}</nobr></div></td>
	  </tr>
    </table>
</div>

</%def>