package rpc;

import java.io.IOException;
import java.io.PrintWriter;
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


/**
 * Servlet implementation class Validation
 */
@WebServlet("/Validation2")
public class Validation2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	    	Connection conn = null;
	    	Statement st = null;
	    	ResultSet rs = null;
	    	System.out.println("success1");
	    	try {
	    		Class.forName("com.mysql.jdbc.Driver");
	    		conn = DriverManager.getConnection("jdbc:mysql://google/lab7?cloudSqlInstance=golden-legend-254717:us-central1:lab8&socke" + 
				"tFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=jli686" + 
				"&password=LiJiaYang989126");
	    	st = conn.createStatement();
			System.out.println("success");
		
			PrintWriter out = response.getWriter();
		    String username = request.getParameter("Username");
		    String password = request.getParameter("Password");
		    String confirmpassword = request.getParameter("ConfirmPassword");
			rs = st.executeQuery("SELECT * from login WHERE Username ='" + username + "'");
			System.out.println("here");
			if(rs.next()) {
				out.println("This username is already taken.");
			} 
			else {
				if(!confirmpassword.equals(password)) {
					out.println("The passwords do not match.");
				}
				else {
					st.executeUpdate("INSERT into login (Username, Password) values "+ "('" + username + "' , '" + password + "')");
					HttpSession session = request.getSession();
					session.setAttribute("username", username);
					System.out.println("hello");
				}
			}
			
		}
		catch (Exception e) {
			System.out.println(e.getMessage());
		} 

	   		
   	 }
	   
	}
