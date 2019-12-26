<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    import="rpc.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>LoginPage</title>
<link rel="stylesheet" href="main.css">
<script>
function validate() {
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET", "Validation2?Username=" + document.myform.Username.value + "&Password=" + document.myform.Password.value + "&ConfirmPassword=" + document.myform.ConfirmPassword.value, false);
	xhttp.send();
	console.log("response:" + xhttp.responseText);
	if (xhttp.responseText.trim().length > 0) {
		document.getElementById("error_msg").innerHTML = xhttp.responseText;
		return false;
	}
	 return true;
    }
</script>
</head>
<body>
<a href = "HomePage.jsp">
<img id = "bookworm1" src="bookworm.png" height="60" width="100">
</a>
<input id = "newinput" type="text" name = "name" placeholder="What book is on your mind?">
<button id = "button" onclick = "search()">
<img src="magnifying_glass.png" height="20" width="40">
</button>
<div id = "test2">
<input id = "1button" type="radio" name="choice" value="Name"><span>Name</span><span id = "garbage">1111111111111111111</span>
<input  type="radio" name="choice" value="ISBN"><span id = "2button">ISBN</span>
</div>
<div id = "test3">
<input id = "3button" type="radio" name="choice" value="Author"><span>Author</span><span id = "garbage">111111111111111111. </span>
<input id = "4button" type="radio" name="choice" value="Publisher"><span>Publisher</span><br>
</div>
<br>
<br>
<br>
<br>
<br>
<br>
<div id = "error_msg">
		
</div>
<form name ="myform" method = "Get" action="HomePage2.jsp" onsubmit="return validate();">
<div id = "Username">
<span id = "garbage">11111111111111111111111111111111.</span>
<span>Username</span>
</div>
<div>
<input id = "input" type = "text" name = "Username">
</div>
<br>
<div id = "Password">
<span id = "garbage">11111111111111111111111111111111.</span>
<span>Password</span>
</div>
<div>
<input id = "input" type = "text" name = "Password">
</div>

<br>
<div id = "ConfirmPassword">
<span id = "garbage">11111111111111111111111111111111.</span>
<span>Confirm Password</span>
</div>
<div>
<input id = "input" type = "text" name = "ConfirmPassword">
</div>
<br>
<br>
<div>
<input id = "input" type="submit" class="signinbutton_css" value="       
                                                                             
            Sign In">
</div>
</form>
</body>
</html>