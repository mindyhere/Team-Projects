package member;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import admin.l_book.LoanDAO;
import admin.l_book.LoanDTO;
import common.PageUtil;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class AdmemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdmemberDAO dao = new AdmemberDAO();
		LoanDAO dao1 = new LoanDAO();
		String url = request.getRequestURL().toString();
		String contextPath = request.getContextPath();
		
		if(url.indexOf("search.do") != -1) {
			
			String search_option = request.getParameter("search_option");
			String search = request.getParameter("search");
			int count =0;
	    	int cur_page = 1;
	    	if (search_option == "" || search == "") {
				count = dao.count();
			} else {
				count = dao.search_count(search_option, search);
			}
			
	    	if(request.getParameter("cur_page") != null) {
	    		cur_page = Integer.parseInt(request.getParameter("cur_page"));
	    	}
	    	PageUtil page = new PageUtil(count,cur_page);
	    	int start=page.getPageBegin();
	    	int end=page.getPageEnd();
	    	List<MemberDTO> list = null;
	    	if (search_option == "" || search == "") {
	    		list = dao.list(start, end);
			} else {
				list = dao.ad_list_search(search_option, search, start, end);
				request.setAttribute("search_option", search_option);
				request.setAttribute("search", search);
			}
			request.setAttribute("list",list);
	    	request.setAttribute("page",page);
	    	RequestDispatcher rd = request.getRequestDispatcher("/admin/member/admin_m_search.jsp");
	    	rd.forward(request,response);
			
		} else if (url.indexOf("ad_list_detail.do") != -1) {
			String m_no = request.getParameter("m_no");
			List<LoanDTO> mem_list = dao1.lo_memlist(m_no);
			MemberDTO de_list = dao.ad_list_detail(m_no);
			
			LoanDTO loan_y = dao1.loan_y(m_no);
			LoanDTO reser_y = dao1.reser_y(m_no);
			request.setAttribute("mem_list",mem_list); //회원상세 리스트
			request.setAttribute("de_list",de_list); //대출현황 리스트
			request.setAttribute("loan_y",loan_y); //대출현황 카운트
			request.setAttribute("reser_y",reser_y); //예약현황 카운트
			String page ="/admin/member/mem_detail.jsp";
			RequestDispatcher rd = request.getRequestDispatcher(page);
			rd.forward(request,response);
		} else if (url.indexOf("list.do")!=-1) {
	         int count = dao.count();
	         int cur_page = 1;
	         if(request.getParameter("cur_page") != null) {
	        	 cur_page=Integer.parseInt(request.getParameter("cur_page"));
	         }
	         PageUtil page = new PageUtil(count,cur_page); //(레코드수, 페이지번호)
	         int start = page.getPageBegin();
	         int end = page.getPageEnd();
	         List<MemberDTO> list = dao.list(start,end); //리스트<레코드>
	         request.setAttribute("list",list); // ("변수명",값) /list.jsp의 list
	         request.setAttribute("page",page);
	         RequestDispatcher rd = request.getRequestDispatcher("/admin/member/admin_m_list.jsp"); //출력페이지
	         rd.forward(request,response);
	         
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
