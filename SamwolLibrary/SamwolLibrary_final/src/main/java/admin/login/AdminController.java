package admin.login;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import admin.chart.ChartDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = request.getRequestURI();
		String path = request.getContextPath();
		AdminDAO dao = new AdminDAO();
		if (url.indexOf("adlogin.do") != -1) {
			String a_id = request.getParameter("a_id");
			String a_passwd = request.getParameter("a_passwd");
			AdminDTO dto = new AdminDTO();
			dto.setA_id(a_id);
			dto.setA_passwd(a_passwd);
			String a_name = dao.login(dto);
			if(a_name==null) {
				String page=path+"/admin/admin_login.jsp?message=error";
				response.sendRedirect(page);
			} else { //로그인 성공
				HttpSession session = request.getSession();
				session.setAttribute("a_id", a_id);
				session.setAttribute("a_name", a_name);
				session.setAttribute("result", a_name+"님 로그인중");
				String page = "/admin/admin_main.jsp";
				RequestDispatcher rd = request.getRequestDispatcher(page);
				rd.forward(request, response);
			}
		} else if(url.indexOf("adlogout.do") != -1) {
			HttpSession session = request.getSession();
			session.invalidate();
			String page ="/admin/admin_login.jsp";
			response.sendRedirect(page);
		}else if(url.indexOf("chart.do") != -1) {
			List<Map<String, Object>> loChart = dao.lo_chart(); 
			JSONArray jso = new JSONArray();
			for(int i=0; i<7; i++) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("L_LODATE", loChart.get(i).get("L_LODATE").toString());
				jsonObj.put("LOAN_BOOK", loChart.get(i).get("LOAN_BOOK").toString());
				jso.add(jsonObj);
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(jso.toString());
		} else if(url.indexOf("ct_cht.do") != -1) {
			List<Map<String, Object>> ct_Chart = dao.ct_chart();
			JSONArray json = new JSONArray();
			for(int j=0; j < ct_Chart.size(); j++) {
				JSONObject jsonObject = new JSONObject();
				jsonObject.put("cnt", ct_Chart.get(j).get("CNT"));
				jsonObject.put("category", ct_Chart.get(j).get("CATEGORY"));
				json.add(jsonObject);
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(json.toString());
		} else if(url.indexOf("ctct.do") != -1) {
			response.sendRedirect(path + "/admin/chart/ct_chart.jsp");
		} else if(url.indexOf("lolo.do") != -1) {
			response.sendRedirect(path + "/admin/chart/loan_chart.jsp");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
