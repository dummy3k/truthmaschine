 $(document).ready(function(){
	$('.contra,.pro,.start').click(function(event) {
             var link = $(this).find('.procontra')[0].href;
             ///console.log(link);
//		document.location =
	});

        $('.comments-area').hide();

        $('.open_comments_link').click(function() {
           var commentsArea = $(this).parent().parent().parent().find('.comments-area');
           commentsArea.toggle();
           console.log(commentsArea);
           return false;
        });

  	$('.comments-input').keyup(function(){
            var len = $(this)[0].value.length;
            var container = $(this).parent().parent().parent().parent();
            var charsLeft = container.find('.comments-characters-left');
            charsLeft.html("(" + (comment_length - len) + " characters left)");
  	});

        $('.comments-post').click(function() {
            var container = $(this).parent().parent().parent().parent().parent();
            var statementid = container.find(".statementid")[0].value;
            var message = container.find(".comments-input")[0].value;

            var results = container.find('.comment-post-results')[0];

            $.ajax({
                url: 'http://localhost:5000/post-comment&message='
                        + $.URLEncode(message)
                        + '&statement='
                        + $.URLEncode(statementid),
                cache: false,
                success: function(html){
                    results.innerHTML = html;
                },
                error: function(httpRequest, textStatus, errorThrown) {
                    results.innerHTML = textStatus;
                }
            });

        });

  	$('#new-argument').keyup(function(){
  	    var markupRegex = /\[(.+?)\|(.+?)\]/g;
  	    var linkRegex = /(^|\s)(http:\/\/[^\s "<>]+)($|\s)/g;

  		var len = $("#new-argument").val().replace(markupRegex, '$2').length;
  		$("#characters-left").html("(" + (statement_length - len) + " characters left)");
  		
  		var escapedHTML=$("#new-argument").val().split("&").join("&amp;").split( "<").join("&lt;").split(">").join("&gt;")
  		
  		$("#preview p").html(escapedHTML.replace(markupRegex, '<a href="$1">$2</a>').replace(linkRegex, '$1<a href="$2">$2</a>$3'))
  		
  	});  	

	 $('#openid-login').click(function(){
		 var url = $('#openid-provider-url').val();
		 url = url.replace('%USER%', $('#openid-username').val());
		 
		 $('#openid').val(url);
		 $('#signin-form').submit();
		 return false;
	 });
 });


 function link_marked_text() {
	 var argument = $("#new-argument");
	 
	 var url = prompt("What url should we link?")
	 
	 // code for IE
	 if(document.selection) {
		 argument.focus();
		 var sel = document.selection.createRange();
		 sel.text = '[' + url + '|' + sel.text + ']';

     // code for everything else...
	 } else {
		 argument.focus();
		 var len = argument.val().length;
		 var start = argument[0].selectionStart;
		 var end = argument[0].selectionEnd;
		 var sel = argument.val().substring(start, end); 
		 
		 var replace = '[' + url + '|' + sel + ']';
		 argument.val(argument.val().substring(0,start) + replace + argument.val().substring(end,len));
	 }
	 
 }
 
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
			$('#openid').val('http://myopenid.com/');
			$('#signin-form').submit();
	 }
	 else if(provider == 'myspace') {
			$('#openid').val('http://myspace.com/');
			$('#signin-form').submit();
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