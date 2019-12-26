<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>"
<!DOCTYPE html>
<html>
<head>
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<script>
function search(){
	var xhttp = new XMLHttpRequest();
	var choices = $("input[name=choice]:checked").val();
	if(choices === "Name") {
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("input").value + "intitle"+ "&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ" , false);
		console.log()
		xhttp.send();
	}
	else if(choices === "ISBN"){
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("input").value + "isbn" + "&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
	}
	else if(choices === "Author"){
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("input").value + "inauthor" + "&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
	}
	else if(choices === "Publisher"){
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("input").value + "inpublisher" + "&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
	}
	else{
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("input").value +"&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
	}
	var searchresult= xhttp.responseText;
	console.log(searchresult);
	searchresult2 = JSON.parse(searchresult);
	console.log(searchresult.totalItems);
    if(searchresult2.totalItems == 0){
    	document.getElementById("error").innerHTML += '<h1 id = "warning">' + "Search results do not exist!" + "</h1>";
    }
    else{
		localStorage.setItem("searchresult", searchresult);
		var userinput = document.getElementById("input").value;
		localStorage.setItem("userinput", userinput);
		window.location.href = "SearchResults2.jsp";
    }
	
}

function profile(){
	window.location.href = "profiles.jsp";
}
function signout(){
	//sessionStorage.clear();
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET","signout");
	xhttp.send();
	window.location.href = "HomePage.jsp";
}
</script>
<meta charset="ISO-8859-1">
<title>HomePage</title>
<link rel="stylesheet" href="main.css">
</head>
<body>
<div id = "background">

<div id = "topbar">
<img id = "bookworm" src="bookworm.png" height="60" width="100">
<input type="button" class="button_css1" value="Profile" onclick = "profile()">
<input type="button" class="button_css1" value="Sign Out" onclick = "signout()">
</div>

<div id = "text">
BookWorm: Just a Mini Program... Happy Days!
</div>

<div>
<br>
</div>
<input id = "input" type="text" name = "name" placeholder=" Search your favorite book!"><br>
<div>
<br>
</div>
<div></div>
<input id = "firstbutton" type="radio" name="choice" value="Name"><span style="color:white">Name</span>
<input id = "secondbutton"type="radio" name="choice" value="ISBN"><span style="color:white">ISBN</span><br>
<input id = "thirdbutton" type="radio" name="choice" value="Author"><span style="color:white">Author</span>
<input id = "fourthbutton"type="radio" name="choice" value="Publisher"><span style="color:white">Publisher</span><br>

<div id = "error">

</div>
<input type="button" class="button_css" value="Search!" onclick = "search()">
</div>
</body>
</html>