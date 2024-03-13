package admin.book;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class BookDAO {
	public int count(String search_option, String keyword) {
		int result = 0;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			result = session.selectOne("book.search_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public int count() {
		int result = 0;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			result = session.selectOne("book.count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public List<BookDTO> list_search(String search_option, String keyword, int start, int end) {
		List<BookDTO> list = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("keyword", keyword);
			map.put("start",start);
			map.put("end",end);
			list = session.selectList("book.list_search", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public List<BookDTO> select_cg() {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<BookDTO> list = null;
		try {
			list = session.selectList("book.select_cg");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public String insert(BookDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String result = "success";
		try {
			session.insert("book.insert", dto);
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

	public BookDTO edit(int b_id) {
		BookDTO list = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			list = session.selectOne("book.edit", b_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public String update(BookDTO dto, String dto_category) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String result = "success";
		try {
			if ((dto.getB_category()+"a").length()==1) {
				dto.setB_category(dto_category);
			}
			session.update("book.update", dto);
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

	public void delete(int b_id) {
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			session.delete("book.delete", b_id);
			session.commit();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
	}

	public List<BookDTO> list(int pageStart, int pageEnd) {
		List<BookDTO> list = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", pageStart);
			map.put("end", pageEnd);
			list = session.selectList("book.list", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;

	}

	public String url_cate(int b_id) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String b_url = null;
		try {
			b_url = session.selectOne("book.url_cate", b_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return b_url;
	}
}
