package admin.book;

import java.io.IOException;
import java.util.List;

import common.PageUtil;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@MultipartConfig(maxFileSize = 1024 * 1024 * 10)
public class BookController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String url = request.getRequestURL().toString();
		String path = request.getContextPath();
		BookDAO dao = new BookDAO();
		if (url.indexOf("search.do") != -1) {
			String search_option = request.getParameter("search_option");
			String keyword = request.getParameter("keyword");
			List<BookDTO> dto = null;
			int count = 0;
			if (search_option == "" || keyword == "") {
				count = dao.count();
			} else {
				count = dao.count(search_option, keyword);
			}
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			if (search_option == "" || keyword == "") {
				dto = dao.list(start, end);
			} else {
				dto = dao.list_search(search_option, keyword, start, end);
				request.setAttribute("search_option", search_option);
				request.setAttribute("keyword", keyword);
			}
			request.setAttribute("dto", dto);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/book/list.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("select_cg.do") != -1) {
			List<BookDTO> list = dao.select_cg();
			request.setAttribute("list", list);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/book/insert.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("insert.do") != -1) {
			BookDTO dto = new BookDTO();
			String filename = "-";
			String result = "";
			ServletContext application = request.getSession().getServletContext();
			String img_path = application.getRealPath("/admin/book_images/");
			try {
				for (Part part : request.getParts()) {
					// 첨부파일 배열
					filename = part.getSubmittedFileName();
					// 파일 이름
					if (filename != null && !filename.equals("null") && !filename.equals("")) {
						part.write(img_path + filename);
						// part.write("C:/work/syLibrary/src/main/webapp/admin/book_images/"+filename);
						// // 디렉토리에 저장
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			String b_name = request.getParameter("b_name");
			String b_author = request.getParameter("b_author");
			String b_pub = request.getParameter("b_pub");
			String b_category = request.getParameter("b_category");
			String b_description = request.getParameter("b_description");
			int b_year = Integer.parseInt(request.getParameter("b_year"));
			String b_isbn = request.getParameter("b_isbn");
			int b_amount = Integer.parseInt(request.getParameter("b_amount"));
			dto.setB_amount(b_amount);
			dto.setB_author(b_author);
			dto.setB_category(b_category);
			dto.setB_description(b_description);
			dto.setB_isbn(b_isbn);
			dto.setB_name(b_name);
			dto.setB_pub(b_pub);
			dto.setB_year(b_year);
			dto.setB_url(filename);
			result = dao.insert(dto);
			request.setAttribute("result", result);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/book/insert.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("list_all.do") != -1) {
			int count = dao.count();
			int cur_page = 1;
			if (request.getParameter("cur_page") != null) {
				cur_page = Integer.parseInt(request.getParameter("cur_page"));
			}
			PageUtil page = new PageUtil(count, cur_page);
			int start = page.getPageBegin();
			int end = page.getPageEnd();
			List<BookDTO> dto = dao.list(start, end);
			request.setAttribute("dto", dto);
			request.setAttribute("page", page);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/book/list.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("edit.do") != -1) {
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			BookDTO dto = dao.edit(b_id);
			List<BookDTO> list = dao.select_cg();
			request.setAttribute("list", list);
			request.setAttribute("dto", dto);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/book/edit.jsp");
			rd.forward(request, response);
		} else if (url.indexOf("update.do") != -1) {
			ServletContext application = request.getSession().getServletContext();
			String img_path = application.getRealPath("/admin/book_images/");
			BookDTO dto = new BookDTO();
			String filename = "-";
			String result = "";
			try {
				for (Part part : request.getParts()) {
					filename = part.getSubmittedFileName();
					if (filename != null && !filename.equals("null") && !filename.equals("")) {
						part.write(img_path + filename);
						break;
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			String b_name = request.getParameter("b_name");
			String b_author = request.getParameter("b_author");
			String b_pub = request.getParameter("b_pub");
			String b_description = request.getParameter("b_description");
			int b_year = Integer.parseInt(request.getParameter("b_year"));
			int b_amount = Integer.parseInt(request.getParameter("b_amount"));
			String b_category = request.getParameter("b_category");
			String dto_category = request.getParameter("dto_category");
			if (filename == null || filename.trim().equals("")) {
				String b_url = dao.url_cate(b_id);
				dto.setB_url(b_url);
			} else {
				dto.setB_url(filename);
			}
			dto.setB_category(b_category);
			dto.setB_id(b_id);
			dto.setB_amount(b_amount);
			dto.setB_author(b_author);
			dto.setB_description(b_description);
			dto.setB_name(b_name);
			dto.setB_pub(b_pub);
			dto.setB_year(b_year);
			result = dao.update(dto, dto_category);
			request.setAttribute("result", result);
			RequestDispatcher rd = request.getRequestDispatcher("/admin/book/edit.jsp");
			rd.forward(request, response);
		}
		if (url.indexOf("delete.do") != -1) {
			int b_id = Integer.parseInt(request.getParameter("b_id"));
			dao.delete(b_id);
			String page = path + "/book_servlet/list_all.do";
			response.sendRedirect(page);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
