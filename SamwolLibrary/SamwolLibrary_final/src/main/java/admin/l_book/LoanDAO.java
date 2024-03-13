package admin.l_book;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import member.MemberDTO;
import sqlmap.MybatisManager;

public class LoanDAO {
	public List<LoanDTO> list(int pageStart, int pageEnd) {
		List<LoanDTO> list = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", pageStart);
			map.put("end", pageEnd);
			list = session.selectList("loanBook.list", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public int count() {
		int result = 0;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			result = session.selectOne("loanBook.count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public int count(String search_option, String keyword) {
		int result = 0;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			result = session.selectOne("loanBook.search_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public List<LoanDTO> list_search(String search_option, String keyword, int start, int end) {
		List<LoanDTO> list = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			map.put("start",start);
			map.put("end",end);
			list = session.selectList("loanBook.list_search", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public String re_book(int l_num) {
		String result = "success";
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			session.update("loanBook.re_book", l_num);
			session.commit();
			session.update("loanBook.re_book_check", l_num);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
			result = "fail";
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public List<LoanDTO> lo_memlist(String m_no) {
	
		List<LoanDTO> mem_list = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("m_no", m_no);
			mem_list = session.selectList("loanBook.lo_memlist", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return mem_list;
	}

	public LoanDTO loan_y(String m_no) {
		SqlSession session = MybatisManager.getInstance().openSession();
		LoanDTO loan_y = session.selectOne("loanBook.loan_y", m_no);
		session.close();
		return loan_y;
	}

	public LoanDTO reser_y(String m_no) {
		SqlSession session = MybatisManager.getInstance().openSession();
		LoanDTO reser_y = session.selectOne("loanBook.reser_y", m_no);
		session.close();
		return reser_y;
	}
}
