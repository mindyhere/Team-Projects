package recommend;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import admin.book.BookDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import search.SearchDAO;

public class RecmdController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		RecmdDAO dao1 = new RecmdDAO();
		SearchDAO dao2 = new SearchDAO();
		String url = request.getRequestURI();

		if (url.contains("list.do")) {
			// 페이지 시작 → 목록 가져오기
			String option = "";
			if (request.getParameter("opt") != null) {
				option = request.getParameter("opt");
			}
			List<BookDTO> list = null;
			String resultPage = "";
			if (option.equals("")) {
				option = "opt1";
				list = dao1.getList(option);
				resultPage = "/user/book/main.jsp";
			} else if (!option.equals("")) {
				list = dao1.getList(option);
				resultPage = "/user/book/recommend.jsp";
			}
			request.setAttribute("list", list);
			request.setAttribute("opt", option);
			RequestDispatcher rd = request.getRequestDispatcher(resultPage);
			rd.forward(request, response);
		} else if (url.contains("showTableList.do")) {
			List<Map<String, Object>> list = null;
			list = dao1.getList();
			request.setAttribute("list", list);
			RequestDispatcher rd = request.getRequestDispatcher("/user/book/modal1.jsp");
			rd.forward(request, response);
		} else if (url.contains("search.do")) {
			// 관리자 → 도서 검색
			String keyword = request.getParameter("keyword");
			List<BookDTO> list = dao2.totSearch(keyword);
			request.setAttribute("list", list);
			RequestDispatcher rd = request.getRequestDispatcher("/user/book/autocomplete.jsp");
			rd.forward(request, response);
		} else if (url.contains("insert.do")) {
			String a_id = request.getParameter("a_id");
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			String result = "";
			result = dao1.insert(a_id, b_id);
			response.getWriter().println(result);
		} else if (url.contains("delete.do")) {
			String option = "";
			String result = "";
			int cnt = Integer.parseInt(request.getParameter("cnt"));
			if (cnt == 5) {
				option = "all";
				result = dao1.delete(option);
			} else if (cnt < 5) {
				option = "delete";
				String arr = request.getParameter("arr");
				String[] values = arr.split(",");

				if (values != null) {
					for (int i = 0; i < values.length; i++) {
						result = dao1.delete(option, Integer.parseInt(values[i]));
						if (result.equals("Not possible")) {
							break;
						}
					}
				}
			}
			response.getWriter().println(result);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
