package action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.UserService;

/**
 * Servlet implementation class UserServlet
 */
@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
	
	UserService service = new UserService();
	
	private static final long serialVersionUID = 1L;
       
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		response.getWriter().println("DoGet");
	}

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String actionType = request.getParameter("actionType");
		
		if ("add".equals(actionType)) {
			addUser(request,response);
		} else if ("update".equals(actionType)) {
			upUser(request,response);
		} else if ("delete".equals(actionType)) {
			delUser(request,response);
		} else if ("select".equals(actionType)) {
			selUser(request, response);
		}else if ("login".equals(actionType)) {
			login(request, response);
		}else if ("selforup".equals(actionType)) {
			selUserForUp(request, response);
		}else {
			System.out.println("Error!");
		}
	}
	
	//登录
	public void login(HttpServletRequest request, HttpServletResponse response) {
		
		String name = request.getParameter("name");
		String pass = request.getParameter("pass");
		String invcode = request.getParameter("invcode");
		
		//Servlet--->JSP[Servlet]: 容器
		try {
			String sql = "select * from user where name=? and password=?";
			List<Map<String,String>> list = service.select(sql,new String[]{name,pass});
			if (list != null) {
				//取出查询结果,匹配输入的信息
				Map<String,String> map = list.get(0);
				if ( name.equals(map.get("name")) && pass.equals(map.get("password")) && invcode.equalsIgnoreCase( VCodeServlet.getVcode() ) ) {
					request.getSession().setAttribute("nowUser", name);
					response.sendRedirect("Home.html");
					return;
				}else {
					System.out.println("E..");
				}
			} 
			
			request.getSession().setAttribute("error", "Login Failed,Try Again!");
			response.sendRedirect("login.jsp");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//查询要修改的用户
	public void selUserForUp(HttpServletRequest request, HttpServletResponse response) {
		
		try {
			String id = request.getParameter("id");//获得被修改数据的id
			String sql = "select * from user where id=?";
			List<Map<String,String>> list = service.select(sql,new String[]{id});//查询要修改的数据
			request.setAttribute("upUsers", list);//将数据存入容器
			
			request.getRequestDispatcher("upUser.jsp").forward(request, response);//跳转到修改页面,然后取出容器的数据,显示给用户
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//查询
	public void selUser (HttpServletRequest request, HttpServletResponse response) {
		
		try {
			String sql = "select *  from  user";
			List<Map<String,String>> list = service.select(sql, new String[0]);
			request.setAttribute("allUsers", list);
			
			request.getRequestDispatcher("view.jsp").forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//删除
	public void delUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String id = request.getParameter("id");
		String[] param = {id};
		int i = service.delete(param);
		
		//响应异步请求
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print(i);
	}

	//修改
	public void upUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		String id = request.getParameter("id");
		String name = request.getParameter("name");//参数名为 页面标签的name值
		String pass = request.getParameter("pass");
		String sex = request.getParameter("sex");
		String age = request.getParameter("age");
		String address = request.getParameter("address");
		String[] param = {name, pass, sex, age, address, id};
		int i = service.update(param);
		
		response.sendRedirect("Status.jsp?i=" + i);
	}

	public void addUser(HttpServletRequest request, HttpServletResponse response) throws IOException {
		
		//服务器将客户端的数据封装到请求对象中,然后调用Servlet方法时,将该请求对象当作为参数传入
		//request.getParameter("") 得到参数名的 页面标签值
		String name = request.getParameter("name");//参数名为 页面标签的name值
		String pass = request.getParameter("pass");
		String sex = request.getParameter("sex");
		String age = request.getParameter("age");
		String address = request.getParameter("address");
		String[] param = {name, pass, sex, age, address};
		int i = service.insert(param);
		response.sendRedirect("Status.jsp?i=" + i);
	}
}
