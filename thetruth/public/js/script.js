 $(document).ready(function(){
  	$('#new-argument').keyup(function(){
  		var markupRegex = /\[(.*?)\|(.*?)\]/g;

  		var len = $("#new-argument").val().replace(markupRegex, '$2').length;
  		$("#characters-left").html("(" + (statement_length - len) + " characters left)");
  		
  		var escapedHTML=$("#new-argument").val().replace(markupRegex, '<a href="$1">$2</a>').split("&").join("&amp;").split( "<").join("&lt;").split(">").join("&gt;")
  		
  		$("#preview p").html(escapedHTML)
  		
  	});  	

	 $('#openid-login').click(function(){
		 var url = $('#openid-provider-url').val();
		 url = url.replace('%USER%', $('#openid-username').val());
		 
		 $('#openid').val(url);
		 $('#signin-form').submit();
		 return false;
	 });
 });

 function hideLoginEntry() {
	 $('#openid-prompt').hide();
 }

 function showLoginPrompt(providerId, providerName, providerUrl) {
	 $('#openid-prompt').show();
	 $('#openid-provider-prompt').html("Your " + providerName + " Account: ");
	 $('#openid-username').val('');
	 $('#openid-provider-url').val(providerUrl);
	 
 }

 function signin(provider) {
	 hideLoginEntry();
	 
	 if(provider == 'openid') {
		$('#openid').val('');
	 }
	 
	 else if(provider == 'google') {
			$('#openid').val('https://www.google.com/accounts/o8/id');
			$('#signin-form').submit();
	 }

	 else if(provider == 'yahoo') {
			$('#openid').val('http://yahoo.com/');
			$('#signin-form').submit();
	 }
	 
	 else if(provider == 'aol') {
		 showLoginPrompt(provider, 'AOL', 'http://openid.aol.com/%USER%');
	 }
	 else if(provider == 'myopenid') {
		 showLoginPrompt(provider, 'MyOpenID', 'http://%USER%.myopenid.com/');
	 }
	 else if(provider == 'livejournal') {
		 showLoginPrompt(provider, 'Livejournal', 'http://%USER%.livejournal.com/');
	 }
	 else if(provider == 'flickr') {
		 showLoginPrompt(provider, 'Flickr', 'http://flickr.com/%USER%/');
	 }
	 else if(provider == 'technorati') {
		 showLoginPrompt(provider, 'Technorati', 'http://technorati.com/people/technorati/%USER%/');
	 }
	 else if(provider == 'wordpress') {
		 showLoginPrompt(provider, 'Wordpress.com', 'http://%USER%.wordpress.com//');
	 }
	 else if(provider == 'blogger') {
		 showLoginPrompt(provider, 'Blogger', 'http://%USER%.blogspot.com/');
	 }
	 else if(provider == 'verisign') {
		 showLoginPrompt(provider, 'Verisign', 'http://%USER%.pip.verisignlabs.com/');
	 }
	 else if(provider == 'vidoop') {
		 showLoginPrompt(provider, 'Vidoop', 'http://%USER%.myvidoop.com/');
	 }
	 else if(provider == 'claimid') {
		 showLoginPrompt(provider, 'ClaimID', 'http://openid.claimid.com/%USER%');
	 }	 
 }