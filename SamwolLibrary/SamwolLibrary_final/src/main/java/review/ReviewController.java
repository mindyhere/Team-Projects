package review;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import admin.book.BookDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ReviewController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		ReviewDAO dao = new ReviewDAO();
		String url = request.getRequestURI();
		if (url.contains("getReviews.do")) {
			// b_id별 등록된 리뷰 목록조회
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			List<Map<String, Object>> reviews = dao.getReviews(b_id);
			request.setAttribute("reviews", reviews);
			String result = "/user/search/reviews.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(result);
			rd.forward(request, response);

		} else if (url.contains("totalList.do")) {
			int b_id = -1;
			List<Map<String, Object>> reviews = dao.getReviews(b_id);
			request.setAttribute("reviews", reviews);
			RequestDispatcher rd = request.getRequestDispatcher("/user/search/totalReviews.jsp");
			rd.forward(request, response);
		} else if (url.contains("insert.do")) {
			String result = "";
			String m_id = request.getParameter("m_id");
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			String contents = request.getParameter("contents");
			
			Map<String, Object> map = new HashMap<>();
			map.put("m_id", m_id);
			map.put("b_id", b_id);
			map.put("contents", contents);
			result = dao.insert(map);
			response.getWriter().println(result);

		} else if (url.contains("delete.do")) {
			String option = request.getParameter("option");
			String result = "";

			String arr = request.getParameter("arr");
			String[] values = arr.split(",");

			if (values != null) {
				switch (option) {
				case "user":
					for (int i = 0; i < values.length; i++) {
						Map<String, Object> map = new HashMap<>();
						String m_id = request.getParameter("m_id");
						int idx = Integer.parseInt(values[i]);
						map.put("m_id", m_id);
						map.put("idx", idx);
						result = dao.delete(map);
						if (result.equals("Error")) {
							break;
						}
					}
					break;
				case "admin":
					for (int i = 0; i < values.length; i++) {
						result = dao.delete(Integer.parseInt(values[i]));
						if (result.equals("Error")) {
							break;
						}
					}
					break;
				}
			}
			response.getWriter().println(result);
		} else if (url.contains("search.do")) {
			String keyword = "";
			String searchOpt = "";
			
			if (request.getParameter("keyword") != null || request.getParameter("keyword") != "") {
				keyword = request.getParameter("keyword");
			}

			if (request.getParameter("searchOpt") != null || request.getParameter("searchOpt") != "") {
				searchOpt = request.getParameter("searchOpt");
			} else {
				searchOpt = "all";
			}
			
			List<Map<String, Object>> list = dao.search(searchOpt, keyword);
			request.setAttribute("reviews", list);
			RequestDispatcher rd = request.getRequestDispatcher("/user/search/totalReviews.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
