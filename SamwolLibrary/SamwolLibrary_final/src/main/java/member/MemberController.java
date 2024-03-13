package member;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10, location = "c:/work/syLibrary/src/main/webapp/resources/images/member")

public class MemberController extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String url = request.getRequestURI();
		String path = request.getContextPath();
		MemberDAO dao = new MemberDAO();

		if (url.contains("join.do")) { // 회원가입
			ServletContext application = request.getSession().getServletContext();
			String mName = request.getParameter("mName");
			String mId = request.getParameter("mId");
			String mPasswd = request.getParameter("mPasswd");
			String mTel = request.getParameter("mTel");
			String mAddress = request.getParameter("mAddress");
			String mEmail = request.getParameter("mEmail");
			String mZipNo = request.getParameter("mZipNo");
			String birthdate = request.getParameter("mBirthDate");
			String mDetailAddress = request.getParameter("mDetailAddress");
			String mImg_path = application.getRealPath("/resources/images/member/");
			String mImg = request.getParameter("mImg");

			if (mImg != null) {
				// 회원 이미지 db 저장
				try {
					for (Part part : request.getParts()) {
						mImg = part.getSubmittedFileName();
						if (mImg != null && !mImg.trim().equals("")) {
							part.write(mImg_path + mImg);
							break;
						}

					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			} else {
				mImg = "image_no.png";
			}
			MemberDTO dto = new MemberDTO();
			dto.setM_name(mName);
			dto.setM_id(mId);
			dto.setM_passwd(mPasswd);
			dto.setM_tel(mTel);
			dto.setM_address(mAddress);
			dto.setM_email(mEmail);
			dto.setM_zip_no(mZipNo);
			dto.setM_birth_date(birthdate);
			dto.setM_detail_address(mDetailAddress);
			dto.setM_img(mImg);

			dao.insert_join(dto);
			String page = "/user/login/login.jsp?message=join";
			response.sendRedirect(path + page);

		} else if (url.contains("detail_memberInfo.do")) { // 회원정보 불러오기
			String mId = request.getParameter("mId");
			MemberDTO dto = dao.detailMember(mId);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/user/member/detail_memberInfo.jsp");
			rd.forward(request, response);
		} else if (url.contains("edit_memberInfo.do")) { // 회원정보 수정
			MemberDTO dto = new MemberDTO();
			ServletContext application = request.getSession().getServletContext();
			String mImg_path = application.getRealPath("/resources/images/member/");
			String mName = request.getParameter("mName");
			String mId = request.getParameter("mId");
			String mPasswd = request.getParameter("mPasswd");
			String mTel = request.getParameter("mTel");
			String mEmail = request.getParameter("mEmail");
			String mZipNo = request.getParameter("mZipNo");
			String mAddress = request.getParameter("mAddress");
			String mDetailAddress = request.getParameter("mDetailAddress");
			String mBirthDate = request.getParameter("mBirthDate");
			String mYear = request.getParameter("mYear");
			String mImg = request.getParameter("mImg");

			// 회원 이미지
			try {
				for (Part part : request.getParts()) {
					mImg = part.getSubmittedFileName();
					if (mImg != null && !mImg.trim().equals("")) {
						part.write(mImg_path + mImg);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			dto.setM_name(mName);
			dto.setM_id(mId);
			dto.setM_passwd(mPasswd);
			dto.setM_tel(mTel);
			dto.setM_email(mEmail);
			dto.setM_zip_no(mZipNo);
			dto.setM_address(mAddress);
			dto.setM_detail_address(mDetailAddress);
			dto.setM_birth_date(mBirthDate);
			dto.setM_year(mYear);

			if (mImg == null || mImg.trim().equals("") || mImg.equals("null")) {
				MemberDTO dto2 = dao.detailMember(mId);
				mImg = dto2.getM_img();
				dto.setM_img(mImg);
			} else {
				dto.setM_img(mImg);
			}

			dao.edit_memberInfo(dto);

			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/user/member/detail_memberInfo.jsp");
			rd.forward(request, response);
		} else if (url.contains("id_check.do")) { // 아이디 중복 확인
			String mId = request.getParameter("mId");
			int idCheck = dao.checkId(mId);
			PrintWriter out = response.getWriter();
			out.print(idCheck + "");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
