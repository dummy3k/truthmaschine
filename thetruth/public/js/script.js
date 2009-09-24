 $(document).ready(function(){
  	$('#new-argument').keyup(function(){
  		var len = $("#new-argument").val().length;
  		$("#characters-left").html("(" + (140 - len) + " characters left)");
  	});  		
  	
 });
