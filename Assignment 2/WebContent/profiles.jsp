<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.ArrayList"
    import="java.sql.Connection"  import= "java.sql.DriverManager"
    import="java.sql.ResultSet"   import= "java.sql.Statement"
    import="javax.servlet.http.HttpSession"
    %>
<!DOCTYPE html>
<html>
<head>
<title>profile</title>
<meta charset="ISO-8859-1">
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>

</head>
<link rel="stylesheet" href="main.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.5.0/css/font-awesome.min.css">
<script src = "https://ajax.googleapis.com/ajax/libs/jquery/2.2.2/jquery.min.js"></script>

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
<input  type="radio" name="choice" value="ISBN"><span id = "2button">ISBN</span><span id = "garbage">111111111111111</span>

<button id="avatar" class="avatar fa fa-user fa-2x" onclick="profile()" ></button>
</div>
<div id = "test3">
<input id = "3button" type="radio" name="choice" value="Author"><span>Author</span><span id = "garbage">111111111111111111. </span>
<input id = "4button" type="radio" name="choice" value="Publisher"><span>Publisher</span><br>
</div>
<br>

<h1 >
<br>
<br>
<span id = "garbage">111111111111111111111111111</span>
<%= session.getAttribute("username") %>'s favorites:
</h1>
<% 
System.out.println("inprofile!");
Connection conn = null;
Statement st = null;
ResultSet rs = null;
ArrayList<String> titles = new ArrayList<String>();
ArrayList<String> authors = new ArrayList<String>();
ArrayList<String> summarys = new ArrayList<String>();
ArrayList<String> ids = new ArrayList<String>();

try {
	Class.forName("com.mysql.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://google/lab7?cloudSqlInstance=golden-legend-254717:us-central1:lab8&socke" + 
	"tFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=jli686" + 
	"&password=LiJiaYang989126");
	st = conn.createStatement();
    session = request.getSession();
	String username = (String) session.getAttribute("username");
	rs = st.executeQuery("SELECT * FROM favorite WHERE Username='" + username + "'" );
	
	System.out.println("inprofile2!");
	while(rs.next()) {
		String title = rs.getString("title");
		System.out.println(title);
		String author = rs.getString("author");
		String summary = rs.getString("summary");
		String id = rs.getString("id");
		titles.add(title);
		authors.add(author);
		summarys.add(summary);
		ids.add(id);
	}
}

catch (Exception e) {
	System.out.println(e.getMessage());
}
 %> 
<script>
var newresult = [];
function remove(val){
	var xhttp = new XMLHttpRequest();
	newresult[val];
	xhttp.open("GET","removes?" + "title=" + newresult[val].volumeInfo.title + "&authors=" + newresult[val].volumeInfo.authors + "&summary=" + newresult[val].volumeInfo.description.substring(4,100) + "&id=" + newresult[val].id);
	console.log("remove1");
	//console.log(document.getElementById('buttonss').innerHTML);
	//if(document.getElementById('buttonss').innerText == "Favorite"){
		//console.log("remove2")
	  // document.getElementById('buttonss').innerText = "Remove";
	//}else{
	//	console.log("remove3")
	  // document.getElementById('buttonss').innerText = "Favorite";
//	}
     xhttp.send();
     var x = document.getElementById("row"+val);
	 x.parentNode.removeChild(x);
     
}
document.addEventListener("DOMContentLoaded",function(){

	var table = document.getElementById("table");
	
	<% int j = -1;%>
	<% for (int i = 0; i < titles.size(); i++) {%>
   		console.log(<%=j%>);
	    var row = document.createElement("tr");
		row.className = "border_bottom"; 
		row.className = "border_top"; 
		row.id = "row" + <%=i%>;
	    var picture = document.createElement("td");
	    var img = document.createElement("img");
	    var xhttp = new XMLHttpRequest();
	    <% System.out.println(ids.get(i));%>
	    xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes/ "+ "<%=ids.get(i)%>" + "?key=AIzaSyBrqLd8RHi4_zMbUIdzCc-KfW5oHcAYtmQ", false);
		xhttp.send();
		console.log(xhttp.responseText);
		var item= xhttp.responseText;
		item = JSON.parse(item);
		console.log(item);
	    img.src = item.volumeInfo.imageLinks.smallThumbnail;
	    var anchor = document.createElement("a");
	    anchor.href = "Details.jsp?id=" + item.id;
	    anchor.appendChild(img);
	    picture.appendChild(anchor);
	    
	    var rightpart = document.createElement("td");
	    rightpart.innerHTML += "<h2>" + "<%=titles.get(i)%>" + "<\h2>";
	    if("<%=authors.get(i)%>"){
	    	rightpart.innerHTML += "<h3>" + "<%=authors.get(i)%>"+ " " + "<\h3>";
	    }
	    
	    	rightpart.innerHTML += "<h3>" +"Summary: "+ "<%=summarys.get(i)%>"+ " " + "<\h3>";
	    
	    	rightpart.innerHTML += "<button id='" + <%=i%> + "'  onclick = 'remove(<%=i%>)'> Remove</button>" ;
	        
	    newresult.push(item);
	    row.appendChild(picture);
	    row.appendChild(rightpart);
	    table.appendChild(row);
	<%}%>
})
</script>


<div id="content">
  <table id = "table" width = "80%" cellspacing="40">
  
  </table>
</div>
</body>
</html>
