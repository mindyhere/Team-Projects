package login;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.json.simple.JSONObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURI();
		String path = request.getContextPath();
		LoginDAO dao = new LoginDAO();
		HttpSession session = request.getSession();
		if (url.contains("login.do")) {
			String mId = request.getParameter("mId");
			String mPasswd = request.getParameter("mPasswd");

			LoginDTO dto = new LoginDTO();
			dto.setM_id(mId);
			dto.setM_passwd(mPasswd);
			String mName = dao.loginCheck(dto);
			session.setAttribute("mId", mId);
			session.setAttribute("mName", mName);
			String page = "/main/index.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request, response);
		} else if (url.indexOf("logout.do") != -1) {
			session.invalidate();
			response.sendRedirect(path + "/main/index.jsp");
		} else if (url.contains("searchId.do")) {
			String mName = request.getParameter("mName");
			String mEmail = request.getParameter("mEmail");
			String mTel = request.getParameter("mTel");
			String birthdate = request.getParameter("mBirthDate");

			LoginDTO dto = new LoginDTO();
			dto.setM_name(mName);
			dto.setM_email(mEmail);
			dto.setM_tel(mTel);
			// String → Date
			try {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date mBirthDate = format.parse(birthdate);
				dto.setM_birth_date(mBirthDate);
			} catch (Exception e) {
				e.printStackTrace();
			}

			String mId = "";
			int status = 0;

			if (mEmail != null && !mEmail.equals("") && !mEmail.equals("null")) { // 이메일로 찾기
				mId = dao.idEmailCheck(dto);
				if (mId != null) {
					status = 1;
				} else {
					status = 2;
				}
			} else if (mTel != null && !mTel.equals("") && !mTel.equals("null")) { // 전화번호로 찾기
				mId = dao.idTelCheck(dto);
				if (mId != null) {
					status = 1;
				} else {
					status = 2;
				}
			}

			response.setContentType("text/html;charset=utf-8");
			JSONObject searchIdResult = new JSONObject();
			searchIdResult.put("mId", mId);
			searchIdResult.put("status", status);
			PrintWriter out = response.getWriter();
			out.print(searchIdResult);
		} else if (url.contains("searchPwd.do")) {
			String mId = request.getParameter("mId");
			String mName = request.getParameter("mName");
			String mEmail = request.getParameter("mEmail");
			String mTel = request.getParameter("mTel");
			String birthdate = request.getParameter("mBirthDate");

			LoginDTO dto = new LoginDTO();
			dto.setM_id(mId);
			dto.setM_name(mName);
			dto.setM_email(mEmail);
			dto.setM_tel(mTel);

			// String → Date
			try {
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				Date mBirthDate = format.parse(birthdate);
				dto.setM_birth_date(mBirthDate);
			} catch (Exception e) {
				e.printStackTrace();
			}

			String mPasswd = "";
			int status = 0;

			if (mEmail != null && !mEmail.equals("") && !mEmail.equals("null")) { // 이메일로 찾기
				mPasswd = dao.pwdEmailCheck(dto);
				if (mPasswd != null) {
					status = 1;
				} else {
					status = 2;
				}
			} else { // 전화번호로 찾기
				mPasswd = dao.pwdTelCheck(dto);
				if (mPasswd != null) {
					status = 1;
				} else {
					status = 2;
				}
			}

			response.setContentType("text/html;charset=utf-8");
			JSONObject searchPwResult = new JSONObject();
			searchPwResult.put("mPasswd", mPasswd);
			searchPwResult.put("status", status);
			PrintWriter out = response.getWriter();
			out.print(searchPwResult);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
