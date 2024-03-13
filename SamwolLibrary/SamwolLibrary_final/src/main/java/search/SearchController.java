package search;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import admin.book.BookDTO;
import checkout.CheckoutDAO;
import common.PageUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SearchController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		SearchDAO dao1 = new SearchDAO();
		CheckoutDAO dao2 = new CheckoutDAO();
		String url = request.getRequestURI();

		if (url.contains("search.do")) {
			// 자료검색페이지 → 키워드로 통합검색(도서명, 작가, 출판사)
			String option = "all";
			String keyword = request.getParameter("keyword"); // 검색키워드
			String view = (request.getParameter("view") != null) ? request.getParameter("view") : "view1";

			// 페이지 설정
			int count = dao1.resultCount(option, keyword);
			int curPage = 1; // 페이지 초기화
			if (request.getParameter("page") != null) {
				curPage = Integer.parseInt(request.getParameter("page"));
			}
			common.PageUtil page = new PageUtil(count, curPage);
			int start = page.getPageBegin();
			int end = page.getPageEnd();

			// 검색 결과 목록 가져오기
			List<BookDTO> list = dao1.totSearch(keyword, start, end);
			List<Map<String, Object>> stateinfo = dao2.listState(list);
			Map<String, Object> cntRec = dao1.countRecords(keyword);
			request.setAttribute("list", list);
			request.setAttribute("stateinfo", stateinfo);
			request.setAttribute("cntRec", cntRec);
			request.setAttribute("count", count);
			request.setAttribute("keyword", keyword);
			request.setAttribute("page", page);
			request.setAttribute("view", view);
			request.setAttribute("option", option);

			RequestDispatcher rd = request.getRequestDispatcher("/user/search/searchResult.jsp");
			rd.forward(request, response);
		} else if (url.contains("detailSearch.do")) {
			String option = "detail";

			String b_name = (request.getParameter("b_name") != null) ? request.getParameter("b_name") : "";
			String b_author = (request.getParameter("b_author") != null) ? request.getParameter("b_author") : "";
			String b_pub = (request.getParameter("b_pub") != null) ? request.getParameter("b_pub") : "";

			String view = (request.getParameter("view") != null) ? request.getParameter("view") : "view1";

			// 페이지 설정
			int count = dao1.resultCount(option, b_name, b_author, b_pub);
			int curPage = 1; // 페이지 초기화
			if (request.getParameter("page") != null) {
				curPage = Integer.parseInt(request.getParameter("page"));
			}
			common.PageUtil page = new PageUtil(count, curPage);
			int start = page.getPageBegin();
			int end = page.getPageEnd();

			List<BookDTO> list = dao1.detailSearch(b_name, b_author, b_pub, start, end);
			List<Map<String, Object>> stateinfo = dao2.listState(list);
			Map<String, Object> cntRec = dao1.countRecords(b_name, b_author, b_pub);
			request.setAttribute("list", list);
			request.setAttribute("stateinfo", stateinfo);
			request.setAttribute("cntRec", cntRec);
			request.setAttribute("count", count);
			request.setAttribute("b_name", b_name);
			request.setAttribute("b_author", b_author);
			request.setAttribute("b_pub", b_pub);
			request.setAttribute("page", page);
			request.setAttribute("view", view);
			request.setAttribute("option", option);

			RequestDispatcher rd = request.getRequestDispatcher("/user/search/detailResult.jsp");
			rd.forward(request, response);

		} else if (url.contains("moveTo.do")) {
			// 파라미터 초기화
			List<BookDTO> list = null;
			List<Map<String, Object>> stateinfo = null;
			int count, curPage, start, end = 0;
			common.PageUtil page = null;
			String resultPage = "";

			String view = (request.getParameter("view") != null) ? request.getParameter("view") : "view1";
			if (view.equals("view1")) {
				resultPage = "/user/search/view1.jsp";
			} else if (view.equals("view2")) {
				resultPage = "/user/search/view2.jsp";
			}

			String option = request.getParameter("option"); // 페이지 나누기용 검색옵션
			switch (option) {
			case "all":
				// 사용자가 입력한 검색어
				String keyword = request.getParameter("keyword");

				// 페이지 설정
				count = dao1.resultCount(option, keyword);
				curPage = Integer.parseInt(request.getParameter("page"));
				page = new PageUtil(count, curPage);
				start = page.getPageBegin();
				end = page.getPageEnd();

				// 검색 결과 목록 가져오기
				list = dao1.totSearch(keyword, start, end);
				stateinfo = dao2.listState(list);
				request.setAttribute("list", list);
				request.setAttribute("stateinfo", stateinfo);
				request.setAttribute("count", count);
				request.setAttribute("keyword", keyword);
				request.setAttribute("page", page);
				request.setAttribute("option", option);
				break;
			case "detail":
				// 사용자가 입력한 검색어

				String b_name = (request.getParameter("b_name") != null) ? request.getParameter("b_name") : "";
				String b_author = (request.getParameter("b_author") != null) ? request.getParameter("b_author") : "";
				String b_pub = (request.getParameter("b_pub") != null) ? request.getParameter("b_pub") : "";

				// 페이지 설정
				count = dao1.resultCount(option, b_name, b_author, b_pub);
				curPage = Integer.parseInt(request.getParameter("page"));
				page = new PageUtil(count, curPage);
				start = page.getPageBegin();
				end = page.getPageEnd();

				// 검색 결과 목록 가져오기
				list = dao1.detailSearch(b_name, b_author, b_pub, start, end);
				stateinfo = dao2.listState(list);
				request.setAttribute("list", list);
				request.setAttribute("stateinfo", stateinfo);
				request.setAttribute("count", count);
				request.setAttribute("b_name", b_name);
				request.setAttribute("b_author", b_author);
				request.setAttribute("b_pub", b_pub);
				request.setAttribute("page", page);
				request.setAttribute("option", option);
				break;
			}
			RequestDispatcher rd = request.getRequestDispatcher(resultPage);
			rd.forward(request, response);

		} else if (url.contains("serachBy.do")) {
			// 파라미터 초기화
			String option = request.getParameter("searchOpt");
			String b_name = (request.getParameter("b_name") != null) ? request.getParameter("b_name") : "";
			String b_author = (request.getParameter("b_author") != null) ? request.getParameter("b_author") : "";
			String b_pub = (request.getParameter("b_pub") != null) ? request.getParameter("b_pub") : "";
			String view = (request.getParameter("view") != null) ? request.getParameter("view") : "view1";
			System.out.println("serachBy option(" + option + ") = b_name: " + b_name + ", b_author=" + b_author
					+ ", b_pub=" + b_pub+", view:"+view);

			// 페이지 설정
			int count = Integer.parseInt(request.getParameter("count"));
			int curPage = 1;
			if (request.getParameter("page") != null) {
				curPage = Integer.parseInt(request.getParameter("page"));
			}
			common.PageUtil page = new PageUtil(count, curPage);
			int start = page.getPageBegin();
			int end = page.getPageEnd();

			// 결과페이지
			String resultPage = "";
			if (view.equals("view1")) {
				resultPage = "/user/search/view1.jsp";
			} else if (view.equals("view2")) {
				resultPage = "/user/search/view2.jsp";
			}

			List<BookDTO> list = dao1.detailSearch(b_name, b_author, b_pub, start, end);
			List<Map<String, Object>> stateinfo = dao2.listState(list);
			Map<String, Object> cntRec = dao1.countRecords(b_name, b_author, b_pub);
			request.setAttribute("list", list);
			request.setAttribute("stateinfo", stateinfo);
			request.setAttribute("cntRec", cntRec);
			request.setAttribute("count", count);
			request.setAttribute("b_name", b_name);
			request.setAttribute("b_author", b_author);
			request.setAttribute("b_pub", b_pub);
			request.setAttribute("page", page);
			request.setAttribute("view", view);
			request.setAttribute("option", option);
			RequestDispatcher rd = request.getRequestDispatcher(resultPage);
			rd.forward(request, response);

		} else if (url.contains("simpleSearch.do")) {
			// 관리자 → 도서 검색
			String keyword = request.getParameter("keyword");
			List<BookDTO> list = dao1.totSearch(keyword);
			request.setAttribute("autoResult", list);
		} else if (url.contains("bookInfo.do")) {
			// 도서 상세정보 페이지
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			BookDTO dtoB = dao1.showDetails(b_id);
			String l_retdate = dao2.fastRetdate(b_id);
			String state = dao2.isAvailable(b_id);
			request.setAttribute("dtoB", dtoB);
			request.setAttribute("l_retdate", l_retdate);
			request.setAttribute("state", state);

			RequestDispatcher rd = request.getRequestDispatcher("/user/search/bookinfo.jsp");
			rd.forward(request, response);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
