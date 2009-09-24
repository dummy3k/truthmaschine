  <form method="post" action="${h.url_for(action='post_edit_statement', id=c.thesis.id)}">
    <textarea name="msg" id="new-argument">${c.thesis.message}</textarea>

    <input type="hidden" name="id" value="${c.thesis.id}" />

    <input type="submit" value="Submit" />
    <span id="characters-left">(140 characters left)</span>
    <br/>

    <p class="hint">Hint: You can link you text using the following syntax: [http://www.google.de|Google]</p>
  </form>
