package rpc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



/**
 * Servlet implementation class favorites
 */
@WebServlet("/favorites")
public class favorites extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection conn = null;
    	PreparedStatement st = null;
    	ResultSet rs = null;
    	System.out.println("success10");
    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		conn = DriverManager.getConnection("jdbc:mysql://google/lab7?cloudSqlInstance=golden-legend-254717:us-central1:lab8&socke" + 
			"tFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=jli686" + 
			"&password=LiJiaYang989126");
        String mystatement = "INSERT into favorite (title, author,summary, id,username) values(?,?,?,?,?)";
    	st = conn.prepareStatement(mystatement);
    	
		System.out.println("success10");
		String title = request.getParameter("title");
		String author = request.getParameter("authors");
		String summary = request.getParameter("summary");
		String id = request.getParameter("id");
		System.out.println(id);
		HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
		//String target = title + "," + author + "," + summary +"," + url + "," + username;
		st.setString(1,title);
		st.setString(2,author);
		st.setString(3,summary);
		st.setString(4,id);
		st.setString(5,username);
		st.executeUpdate();
		//st.executeUpdate("INSERT into favorite (title, author,summary, isbn,username) values "+ "('" + title + "' , '" + author + "' , '" + summary + "' + '" + url + "' + '" + username + "')");
    	}
    	catch (Exception e) {
			System.out.println(e.getMessage());
		}

}
}
