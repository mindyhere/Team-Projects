package checkout;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import admin.l_book.ReBookDTO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ResBookController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURI();
		String path = request.getContextPath();
		ResBookDAO dao = new ResBookDAO();

		// 예약 가능여부 확인
		if (url.contains("recheck_book.do")) {
			int r_bookid = Integer.parseInt(request.getParameter("b_id"));
			String m_id = request.getParameter("m_id");
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("r_bookid", r_bookid);
			map.put("m_id", m_id);
			// 3권 체크
			int reCnt = dao.recheck_book(map);
			// 중복체크
			int dupCnt = dao.recheck_duplicate(map);
			// 최종 상태( 1: 3권이상, 2: 중복, 3: 예약가능)
			int status = 0;
			if (reCnt < 3) {// 3권 미만 예약 중
				if (dupCnt == 0) { // 예약 가능
					status = 3;
					dao.insert_resbook(map);// 예약데이터 저장
				} else if (dupCnt == 1) { // 예약 불가
					status = 2;
				}
			} else if (reCnt >= 3) { // 3권 이상 예약 중
				status = 1;
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(status);
		}
		// 예약 도서 리스트
		else if (url.contains("myReBook.do")) {
			String r_memno = request.getParameter("mId");
			List<ReBookDTO> myReBook = dao.myReBook(r_memno);
			request.setAttribute("myReBook", myReBook);
			RequestDispatcher rd = request.getRequestDispatcher("/user/book/myReBook.jsp");
			rd.forward(request, response);
		}
		// 도서 예약 취소
		else if (url.contains("re_delete.do")) {
			String m_id = request.getParameter("m_id");
			int r_bookid = Integer.parseInt(request.getParameter("r_bookid"));
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("m_id", m_id);
			map.put("r_bookid", r_bookid);
			dao.res_delete(map);
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(m_id);
		} else if (url.contains("reservation.do")) {
			String r_memno = request.getParameter("mId");
			List<ReBookDTO> myReBook = dao.myReBook(r_memno);
			request.setAttribute("myReBook", myReBook);
			JSONArray json = new JSONArray();
			for (int i = 0; i < myReBook.size(); i++) {
				JSONObject result = new JSONObject();
				result.put("r_reservation", myReBook.get(i).getR_reservation());
				result.put("b_id", myReBook.get(i).getB_id());
				result.put("b_name", myReBook.get(i).getB_name());
				json.add(result);
			}
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(json.toString());
		} else if (url.contains("delete.do")) {
			String m_id = request.getParameter("m_id");
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("m_id", m_id);
			map.put("b_id", b_id);
			dao.myResDelete(map);
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			out.print(m_id);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
