package rpc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.PrintWriter;

/**
 * Servlet implementation class Button
 */
@WebServlet("/Button")
public class Button extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Connection conn = null;
    	Statement st = null;
    	ResultSet rs = null;
    	System.out.println("success10");
    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		conn = DriverManager.getConnection("jdbc:mysql://google/lab7?cloudSqlInstance=golden-legend-254717:us-central1:lab8&socke" + 
			"tFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=jli686" + 
			"&password=LiJiaYang989126");
    	st = conn.createStatement();
    	System.out.println("success101");
    	String id = request.getParameter("id");
    	HttpSession session = request.getSession();
		String username = (String) session.getAttribute("username");
    	rs = st.executeQuery("SELECT * from favorite WHERE Username ='" + username + "' AND id='" + id + "'");
    	System.out.println("here101");
    	PrintWriter out = response.getWriter();
    	
    	if(username == null) {
    		System.out.println("user not logged in");
    		out.println("1"); //no user logged in
    		out.flush();
    	} else {
    		if(rs.next())
    		{
    			System.out.println("user logged in and favorited");
    			out.println("2"); //has already favored, should display remove
    			out.flush();
    		}
    		else {
    			System.out.println("user logged in and not favorited");
    			out.println("3"); //should display favorite
    			out.flush();
    		}
    		
    	}
    	}
    	catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}


}
