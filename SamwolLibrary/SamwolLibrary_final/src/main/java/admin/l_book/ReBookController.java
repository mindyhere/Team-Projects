package admin.l_book;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import member.MemberDTO;

import java.io.IOException;
import java.util.List;
import common.PageUtil;

import admin.l_book.ReBookDAO;
import admin.l_book.ReBookDTO;

public class ReBookController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String url = request.getRequestURL().toString();
		String contextPath = request.getContextPath();
		ReBookDAO dao = new ReBookDAO();
		
		if (url.indexOf("search.do") != -1) {
	    	String search_option = request.getParameter("search_option");
	    	String search = request.getParameter("search");
	    	int count =0;
	    	int cur_page = 1;
	    	if (search_option == "" || search == "") {
				count = dao.count();
			} else {
				count = dao.count(search_option, search);
			}
	    	if(request.getParameter("cur_page") != null) {
	    		cur_page = Integer.parseInt(request.getParameter("cur_page"));
	    	}
	    	PageUtil page = new PageUtil(count,cur_page);
	    	int start=page.getPageBegin();
	    	int end=page.getPageEnd();
	    	List<ReBookDTO> list = null;
	    	if (search_option == "" || search == "") {
	    		list = dao.list(start, end);
			} else {
				list = dao.list_search(search_option,search,start,end);
				request.setAttribute("search_option", search_option);
				request.setAttribute("search", search);
			}
	    	request.setAttribute("list",list);
	    	request.setAttribute("page",page);
	    	RequestDispatcher rd = request.getRequestDispatcher("/admin/l_book/re_search.jsp");
	    	rd.forward(request,response);
	    } else if (url.indexOf("list.do")!=-1) { //문자열.contains(키워드)-true/false
	         int count = dao.count();
	         int cur_page = 1;
	         if(request.getParameter("cur_page") != null) {
	        	 cur_page=Integer.parseInt(request.getParameter("cur_page"));
	         }
	         PageUtil page = new PageUtil(count,cur_page); //(레코드수, 페이지번호)
	         int start = page.getPageBegin();
	         int end = page.getPageEnd();
	         List<ReBookDTO> list = dao.list(start,end); //리스트<레코드>
	         request.setAttribute("list",list); // ("변수명",값) /list.jsp의 list
	         request.setAttribute("page",page);
	         RequestDispatcher rd = request.getRequestDispatcher("/admin/l_book/re_list.jsp"); //출력페이지
	         rd.forward(request,response);
	    }
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
