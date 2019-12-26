<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>SearchResults</title>
<link rel="stylesheet" href="main.css">
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<script>
function search(){
	var xhttp = new XMLHttpRequest();
	var choices = $("input[name=choice]:checked").val();
	if(choices === "Name") {
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("newinput").value + "intitle"+ "&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ" , false);
		console.log()
		xhttp.send();
	}
	else if(choices === "ISBN"){
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("newinput").value + "isbn" + "&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
	}
	else if(choices === "Author"){
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("newinput").value + "inauthor" + "&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
	}
	else if(choices === "Publisher"){
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("newinput").value + "inpublisher" + "&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
	}
	else{
		xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q= "+document.getElementById("newinput").value +"&key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
	}
	var searchresult= xhttp.responseText;
	console.log(xhttp.responseText);
	localStorage.setItem("searchresult", searchresult);
	var userinput = document.getElementById("newinput").value;
	localStorage.setItem("userinput", userinput);
	document.getElementById("resulttext").innerHTML = "Results for "+ userinput;
	location.reload();
	
}
	document.addEventListener("DOMContentLoaded",function(){
		var result = localStorage.getItem("searchresult");
		result = JSON.parse(result);
		
		var userinput = localStorage.getItem("userinput");
		document.getElementById("resulttext").innerHTML = "Results for "+ userinput;
		console.log(result);
		var table = document.getElementById("table");
		for (var i = 0; i < result.items.length; i++) {
	    var item = result.items[i];
	   
	    var row = document.createElement("tr");
		row.className = "border_bottom"; 
		row.className = "border_top"; 
	    var picture = document.createElement("td");
	    var img = document.createElement("img");
	    img.src = item.volumeInfo.imageLinks.smallThumbnail;
	    var anchor = document.createElement("a");
	    anchor.href = "Details.jsp?id=" + item.id;
	    anchor.appendChild(img);
	    picture.appendChild(anchor);
	    
	    var rightpart = document.createElement("td");
	    rightpart.innerHTML += "<h2>" + item.volumeInfo.title + "<\h2>";
	    if(item.volumeInfo.authors){
	    	rightpart.innerHTML += "<h3>" + item.volumeInfo.authors + " " + "<\h3>";
	    }
	    if(item.searchInfo){
	    	rightpart.innerHTML += "Summary: " + item.searchInfo.textSnippet + "<br";
	    }
	    row.appendChild(picture);
	    row.appendChild(rightpart);
	    table.appendChild(row);
	    
	  	}
	})
	
</script>
</head>
<body>
<a href = "HomePage.jsp">
<img id = "bookworm1" src="bookworm.png" height="60" width="100">
</a>
<input id = "newinput" type="text" name = "name" placeholder="What book is on your mind?">
<button id = "button" onclick = "search()">
<img src="magnifying_glass.png" height="20" width="20">
</button>
<div id = "test0">
<input id = "1button" type="radio" name="choice" value="Name"><span>Name</span><span id = "garbage">1111111111111111111. </span>
<input  type="radio" name="choice" value="ISBN"><span id = "2button">ISBN</span>
</div>
<div id = "test">
<input id = "3button" type="radio" name="choice" value="Author"><span>Author</span><span id = "garbage">111111111111111111. </span>
<input id = "4button" type="radio" name="choice" value="Publisher"><span>Publisher</span><br>
</div>
<br>
<br>
<div id = "resulttext">

</div>
<br>
<table id="table" width = "80%" cellspacing="40"> 
  
</table>
</body>
</html>