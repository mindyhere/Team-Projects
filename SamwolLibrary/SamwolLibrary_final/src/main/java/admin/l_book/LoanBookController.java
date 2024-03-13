package admin.l_book;

import java.io.IOException;
import java.util.List;

import common.PageUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.MemberDTO;

public class LoanBookController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		String path = request.getContextPath();
		LoanDAO dao = new LoanDAO();
		if(url.indexOf("list.do")!=-1) {
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<LoanDTO> dto = dao.list(start, end);
			request.setAttribute("dto", dto);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/l_book/loan.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("search.do") != -1) {
			String search_option = request.getParameter("search_option");
			String keyword = request.getParameter("keyword");
			List<LoanDTO> dto = null;
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
			RequestDispatcher rd = request.getRequestDispatcher("/admin/l_book/loan.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("re_book.do") != -1) {
			int l_num = Integer.parseInt(request.getParameter("l_num"));
			String result = dao.re_book(l_num);
			request.setAttribute("result", result);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/l_book/loan.jsp");
			rd.forward(request, response);
		} 
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
