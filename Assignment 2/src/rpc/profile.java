package rpc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class profile
 */
@WebServlet("/profile")
public class profile extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("inprofile!");
		Connection conn = null;
    	Statement st = null;
    	ResultSet rs = null;
    	try {
    		Class.forName("com.mysql.jdbc.Driver");
    		conn = DriverManager.getConnection("jdbc:mysql://google/lab7?cloudSqlInstance=golden-legend-254717:us-central1:lab8&socke" + 
			"tFactory=com.google.cloud.sql.mysql.SocketFactory&useSSL=false&user=jli686" + 
			"&password=LiJiaYang989126");
    		st = conn.createStatement();
    		HttpSession session = request.getSession();
    		String username = (String) session.getAttribute("username");
    		rs = st.executeQuery("SELECT * FROM favorite WHERE Username='" + username + "'" );
    		
    		System.out.println("inprofile2!");
    		ArrayList<String> titles = new ArrayList<String>();
    		ArrayList<String> authors = new ArrayList<String>();
    		ArrayList<String> summarys = new ArrayList<String>();
    		ArrayList<String> urls = new ArrayList<String>();
    		while(rs.next()) {
    			String title = rs.getString("title");
    			System.out.println(title);
    			String author = rs.getString("author");
    			String summary = rs.getString("summary");
    			String url = rs.getString("url");
    			titles.add(title);
    			authors.add(author);
    			summarys.add(summary);
    			urls.add(url);
    		}
    		request.setAttribute("titles", titles);
			request.setAttribute("authors",authors);
			request.setAttribute("summarys", summarys);
			request.setAttribute("urls", urls);
	    }
    	
    	catch (Exception e) {
			System.out.println(e.getMessage());
		}
    	String nextJSP = "/profiles.jsp";
    	System.out.println("inprofile3!");
		RequestDispatcher dispatcher = 
		getServletContext().getRequestDispatcher(nextJSP);
		dispatcher.forward(request,response);

}
}
