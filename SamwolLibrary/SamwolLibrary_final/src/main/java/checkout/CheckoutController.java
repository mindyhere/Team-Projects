package checkout;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class CheckoutController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String m_id = request.getParameter("m_id");
		int b_id = Integer.parseInt(request.getParameter("b_id"));
		CheckoutDAO dao = new CheckoutDAO();
		String url = request.getRequestURI();

		if (url.contains("checkout.do")) {
			int check = dao.checkMloan(m_id, b_id); // 회원의 도서대출 가능여부 확인
			String result = ""; // 처리결과 확인을 위한 파라미터
			switch (check) {
			case 1:
				result = dao.checkout(m_id, b_id);
				break;
			case 0: // 신청불가
				result = "Not possible";
				break;
			}
			
			response.getWriter().println(result);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
