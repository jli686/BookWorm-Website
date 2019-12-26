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

/**
 * Servlet implementation class removes
 */
@WebServlet("/removes")
public class removes extends HttpServlet {
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
    	System.out.println("success");
    	String id = request.getParameter("id");
    	System.out.println("removing id " + id);
    	st.executeUpdate("DELETE FROM favorite WHERE id ='" + id + "'");
    	System.out.println("here");
    	}
    	catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}


}
