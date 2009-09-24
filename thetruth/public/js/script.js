 $(document).ready(function(){
  	$('#new-argument').keyup(function(){
  		var stripMarkupRegex = /\[(.*?)\|(.*?)\]/;
  		
  		var len = $("#new-argument").val().replace(stripMarkupRegex, '\\2').length;
  		$("#characters-left").html("(" + (140 - len) + " characters left)");
  	});  	
 });
