package myLibrary;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MyLibraryController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURI();
		MyLibraryDAO dao = new MyLibraryDAO();
		if (url.contains("myLibray_info.do")) { // 나의 서재
			String mId = request.getParameter("mId");
			MyLibraryDTO myLibrary = dao.myLibrary_list(mId);
			request.setAttribute("myLibrary", myLibrary);
			RequestDispatcher rd = request.getRequestDispatcher("/user/book/myLibrary.jsp");
			rd.forward(request, response);
		} else if (url.contains("myLoanBook.do")) { // 나의 대출 도서 현황
			int mNo = Integer.parseInt(request.getParameter("mNo"));
			List<MyLibraryDTO> myLoanBook = dao.myLoanBook(mNo);
			request.setAttribute("myLoanBook", myLoanBook);
			RequestDispatcher rd = request.getRequestDispatcher("/user/book/myLoanBook.jsp");
			rd.forward(request, response);
		} else if (url.contains("myHistory.do")) { // 나의 대출 이력
			int mNo = Integer.parseInt(request.getParameter("mNo"));
			List<MyLibraryDTO> myHistory = dao.myHistory(mNo);
			request.setAttribute("myHistory", myHistory);
			RequestDispatcher rd = request.getRequestDispatcher("/user/book/myHistory.jsp");
			rd.forward(request, response);
		} else if (url.contains("renew.do")) { // 연장 신청
			int mNo = Integer.parseInt(request.getParameter("mNo"));
			int bId = Integer.parseInt(request.getParameter("bId"));
			Map<String, Object> map = new HashMap<>();
			map.put("l_memno", mNo);
			map.put("l_bookid", bId);
			// 예약 여부 확인
			int reCnt = dao.checkReservation(bId);
			String renewYn = dao.checkRenewYn(map);
			int status = 0;
			if (reCnt == 0) {
				if (renewYn.equals("N")) {
					dao.updateReturn(map);
					status = 0;
				} else if (renewYn.equals("Y")) {
					status = 1;
				}
			} else if (reCnt > 0) {
				status = 2;
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(status);
		} else if (url.contains("createChart.do")) { // 차트 그리기
			int mNo = Integer.parseInt(request.getParameter("mNo"));
			String type = request.getParameter("type");
			String title = "";
			List<Map<String, Object>> cateChart = null;

			if (type.equals("cate")) { // 카테고리별 통계
				cateChart = dao.cateChart(mNo);
				title = "카테고리별 통계";
			} else if (type.equals("month")) { // 반기별 통계
				cateChart = dao.monthChart(mNo);
				title = "반기별 통계";
			} else if (type.equals("year")) { // 연도별 통계
				cateChart = dao.yearChart(mNo);
				title = "연도별 통계";
			}

			JSONArray json = new JSONArray();
			for (int i = 0; i < cateChart.size(); i++) {
				JSONObject chartResult = new JSONObject();
				chartResult.put("category", cateChart.get(i).get("CATEGORY"));
				chartResult.put("cnt", cateChart.get(i).get("TOTAL_CNT"));
				chartResult.put("title", title);
				json.add(chartResult);
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(json.toString());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
