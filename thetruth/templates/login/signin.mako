<%inherit file="/layout-default.mako"/>\

<%def name="content()">
  <h1>Sign in with OpenID</h1>

  % if c.message:
  <p class="error">
    ${c.message}
  </p>
  % endif

  
  <form method="post" action="${h.url_for(controller='login', action='signin_POST')}">
    <input type="text" size="20" name="openid" class="openid-identifier" style="height: 28px" />
    <input type="submit" value="Login" />
  </form>
  
  <p class="hint">
    Don't forget to enable OpenID support with your preferred provider first!
  </p>
  
</%def>
<%def name="sidenav()">
<h1>What is OpenID?</h1>

<p>It's a single username and password that allows you to log in to any OpenID-enabled site.</p>

<p>It works on thousands of websites.</p>

<p>It's an open standard.</p>

<p>And we are too lazy to implement our own login process. Which is good, because this way we can't mess it up.</p>

<ul>
    <li><a href="http://openid.net/what/">learn more</a></li>
    <li><a href="http://openid.net/get/">get one</a></li>
</ul>
</%def>