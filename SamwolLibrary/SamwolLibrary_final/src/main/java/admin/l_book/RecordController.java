package admin.l_book;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import org.json.simple.JSONObject;

import common.PageUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RecordController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		String path = request.getContextPath();
		RecordDAO dao = new RecordDAO();
		if(url.indexOf("list.do")!=-1) {
			int count = dao.count();
			int cur_page = 1;
			String result = request.getParameter("result");
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<RecordDTO> dto = dao.list(start, end);
			request.setAttribute("dto", dto);
			request.setAttribute("page", page);
			request.setAttribute("result", result);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/l_book/lo_record.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("search.do") != -1) {
			String search_option = request.getParameter("search_option");
			String keyword = request.getParameter("keyword");
			List<RecordDTO> dto = null;
			int count = 0;
			if (search_option == "" || keyword == "") {
				count = dao.count();
			} else {
				count = dao.count(search_option, keyword);
			}
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			if (search_option == "" || keyword == "") {
				dto = dao.list(start, end);
			} else {
				dto = dao.list_search(search_option, keyword, start, end);
				request.setAttribute("search_option", search_option);
				request.setAttribute("keyword", keyword);
			}
			request.setAttribute("dto", dto);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/l_book/lo_record.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("email.do") != -1) {
			int l_num = Integer.parseInt(request.getParameter("l_num"));
			String email = dao.member_email(l_num);
			JSONObject jso = new JSONObject();
			jso.put("data", email);
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(jso.toString());
		} if(url.indexOf("order.do")!=-1) {
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<RecordDTO> dto = dao.order(start, end);
			request.setAttribute("dto", dto);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/l_book/lo_record.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
