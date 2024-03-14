package admin.l_book;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

public class EmailController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		String path = request.getContextPath();
		RecordDAO dao = new RecordDAO();
		if (url.indexOf("send.do") != -1) {
			String sender_name = "SY Library";
			String sender_mail = "";
			String receive_mail = request.getParameter("receive_mail");
			String subject = request.getParameter("subject");
			String message = request.getParameter("message");
			String result = "success";
			EmailDTO dto = new EmailDTO();
			dto.setSenderName(sender_name);
			dto.setSenderMail(sender_mail);
			dto.setReceiveMail(receive_mail);
			dto.setSubject(subject);
			dto.setMessage(message);
			EmailService service = new EmailService();
			try {
				service.mailSender(dto);
			} catch (Exception e) {
				e.printStackTrace();
				result = "fail";
			}
			response.sendRedirect(request.getContextPath() + "/record_servlet/order.do?result=" + result);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
