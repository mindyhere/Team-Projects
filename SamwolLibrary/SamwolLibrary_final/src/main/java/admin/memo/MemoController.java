package admin.memo;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import member.MemberDTO;
import admin.login.AdminDAO;
import admin.memo.MemoDAO;
import common.PageUtil2;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;

public class MemoController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		MemoDAO dao = new MemoDAO();
		AdminDAO dao1 = new AdminDAO();
		String url = request.getRequestURL().toString();
		if (url.indexOf("list.do") != -1) {
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil2 page = new PageUtil2(count, cur_page); // (레코드수, 페이지번호)
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<MemoDTO> list = dao.list(start, end); // 리스트<레코드>
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/main/memo_list.jsp"); // 출력페이지
			rd.forward(request, response);
		} else if (url.indexOf("insert.do") != -1) {
			String me_a_id = request.getParameter("me_a_id");
			String me_memo = request.getParameter("me_memo");
			MemoDTO dto = new MemoDTO();
			dto.setMe_a_id(me_a_id);
			dto.setMe_memo(me_memo);
			dao.insert(dto);
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil2 page = new PageUtil2(count, cur_page); 
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<MemoDTO> list = dao.list(start, end);
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_main.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("delete.do") != -1) {
			int me_rownum = Integer.parseInt(request.getParameter("me_rownum"));
			dao.delete(me_rownum);
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil2 page = new PageUtil2(count, cur_page); 
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<MemoDTO> list = dao.list(start, end);
			request.setAttribute("list", list);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/admin_main.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("update.do") != -1) {
			MemoDTO memo = new MemoDTO();
			int me_rownum = Integer.parseInt(request.getParameter("me_rownum"));
			String me_a_id = request.getParameter("me_a_id");
			String me_memo = request.getParameter("me_memo");
			memo.setMe_a_id(me_a_id);
			memo.setMe_rownum(me_rownum);
			memo.setMe_memo(me_memo);
			dao.update(memo);
		} else if (url.indexOf("search.do") != -1) {
			int me_rownum = Integer.parseInt(request.getParameter("me_rownum"));
			MemoDTO memo = dao.search(me_rownum);
			JSONObject jso = new JSONObject();
			jso.put("me_a_id", memo.getMe_a_id());
			jso.put("me_rownum", memo.getMe_rownum());
			jso.put("a_name", memo.getA_name());
			jso.put("me_memo", memo.getMe_memo());
			jso.put("me_post_date", memo.getMe_post_date());
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(jso.toString());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
