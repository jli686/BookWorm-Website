<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" href="main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>
<style>
.checked {
  color: orange;
}
</style>
</head>
<body>
<script>
var item;
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
	window.location.href = "SearchResults.jsp";	
}

function remove(){
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET","removes?" + "title=" + item.volumeInfo.title + "&authors=" + item.volumeInfo.authors + "&summary=" + item.volumeInfo.description.substring(4,100) + "&id=" + item.id);
	console.log("remove1");
	if(document.getElementById('buttonss').innerText == "Favorite"){
		console.log("here2")
	   document.getElementById('buttonss').innerText = "Remove";
	   document.getElementById('buttonss').onclick = remove;
	}else{
		console.log("here3")
	   document.getElementById('buttonss').innerText = "Favorite";
	   document.getElementById('buttonss').onclick = favorite;
	}
	xhttp.send();
}
function profile(){
	//var xhttp = new XMLHttpRequest();
	//console.log("HERE");
	//xhttp.open("GET","profile");
	//xhttp.send();
	window.location.href = "profiles.jsp";
}
function error(){
	window.alert("No user logged in!");
}
function favorite(){
	
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET","favorites?" + "title=" + item.volumeInfo.title + "&authors=" + item.volumeInfo.authors + "&summary=" + item.volumeInfo.description.substring(4,100) + "&id=" + "<%=request.getParameter("id")%>");
	
		console.log("here1");
		console.log(document.getElementById('buttonss').innerHTML);
		if(document.getElementById('buttonss').innerText == "Favorite"){
			console.log("here2")
		   document.getElementById('buttonss').innerText = "Remove";
		   document.getElementById('buttonss').onclick = remove;
		}else{
			console.log("here3")
		   document.getElementById('buttonss').innerText = "Favorite";
		   document.getElementById('buttonss').onclick = favorite;
		}
	xhttp.send();
	
}

document.addEventListener("DOMContentLoaded",function(){
	/*var json = JSON.parse(localStorage.getItem("myjson"));
	console.log(json.volumeInfo.title);
	var row = document.createElement("tr");
	var picture = document.createElement("td");
	var img = document.createElement("img");*/
	
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes/ "+ "<%=request.getParameter("id")%>" + "?key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
	xhttp.send();
	item= JSON.parse(xhttp.responseText);
	//localStorage.setItem("item", item);
	console.log(item);
	
	var table = document.getElementById("mytable");
	var row = document.createElement("tr");
	var picture = document.createElement("td");
	picture.style = "margin-top:10px; margin-left:80px;"
	var img = document.createElement("img");
	console.log(item);
	img.src = item.volumeInfo.imageLinks.smallThumbnail;
	var anchor = document.createElement("a");
	anchor.href = "SearchResults.jsp";
	anchor.appendChild(img);
	picture.appendChild(anchor);
	
	var rightpart = document.createElement("td");
	rightpart.innerHTML += "<h3>" + item.volumeInfo.title + "<\h3>";
	console.log(item);
	if(item.volumeInfo.authors){
    	rightpart.innerHTML += "<h4>" + "Author: "+ item.volumeInfo.authors + " " + "<\h4>";
    }
	if(item.volumeInfo.publisher){
		rightpart.innerHTML += "<h5>" + "Publisher: " + item.volumeInfo.publisher + " " + "<\h5>";
	}
	if(item.volumeInfo.publishedDate){
		rightpart.innerHTML += "<h5>" + "Published Date: " + item.volumeInfo.publishedDate + " " + "<\h5>";
	}
	if(item.volumeInfo.industryIdentifiers[1].identifier){
		rightpart.innerHTML += "<h5>" + "ISBN: " + item.volumeInfo.industryIdentifiers[1].identifier + " " + "<\h5>";
	}
	if(item.volumeInfo.description){
    	rightpart.innerHTML += "Summary: " + item.volumeInfo.description.substring(4,180) + "..." + "<br>" + "<br>";
    }
	console.log("line 100:");
	//console.log(session.getAttribute("username"));
	if(item.volumeInfo.averageRating){
		rightpart.innerHTML += "Rating: ";
		var a = Math.round(item.volumeInfo.averageRating);
		var i = 0;
		for(i; i < a; i++){
			rightpart.innerHTML += '<span class="fa fa-star checked">' + "</span>";
		}
		i = 0;
		a = 5 - a;
		for(i; i < a; i++){
			rightpart.innerHTML += '<span class="fa fa-star">' + "</span>";
		}
		rightpart.innerHTML +="<br>";
	}
	var xhttp = new XMLHttpRequest();
	xhttp.open("GET", "Button?id=" + item.id, false);
	xhttp.send();
	var state= xhttp.responseText;
	console.log(state);
	console.log(state == 2);
	if(state ==1){
		//window.alert("No user logged in!")
		rightpart.innerHTML += "<button id='buttonss' onclick = 'error()'> Favorite</button>" ;
	}
	else if(state == 2){
		 rightpart.innerHTML += "<button id='buttonss' onclick = 'remove()'> Remove</button>" ;
	}
	else{
		 rightpart.innerHTML += "<button id='buttonss' onclick = 'favorite()'> Favorite</button>" ;
	}

	rightpart.style = "margin-top:50px; padding-left:100px; padding-top:110px;";
	row.appendChild(picture);
    row.appendChild(rightpart);
    table.appendChild(row);
	
})

</script>
<a href = "HomePage.jsp">
<img id = "bookworm1" src="bookworm.png" height="60" width="100">
</a>
<input id = "newinput" type="text" name = "name" placeholder="What book is on your mind?">
<button id = "button" onclick = "search()">
<img src="magnifying_glass.png" height="20" width="40">
</button>
<div id = "test2">
<input id = "1button" type="radio" name="choice" value="Name"><span>Name</span><span id = "garbage">1111111111111111111</span>
<input  type="radio" name="choice" value="ISBN"><span id = "2button">ISBN</span><span id = "garbage">111111111111111</span>

<button id="avatar" class="avatar fa fa-user fa-2x" onclick="profile()" ></button>
</div>
<div id = "test3">
<input id = "3button" type="radio" name="choice" value="Author"><span>Author</span><span id = "garbage">111111111111111111. </span>
<input id = "4button" type="radio" name="choice" value="Publisher"><span>Publisher</span><br>
</div>
<br>
<div id="content">
  <table id = "mytable" style="margin-top:10px; margin-left:80px;">
  
  </table>
</div>
</body>
</html>