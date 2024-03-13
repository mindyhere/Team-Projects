package admin.l_book;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import admin.l_book.ReBookDTO;
import sqlmap.MybatisManager;

public class ReBookDAO {

	public List<ReBookDTO> list_search(String search_option, String search, int start, int end) {
		List<ReBookDTO> list = null;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("search", search);
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("rebook.search_list", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session!=null)
				session.close();
		}
		return list;
	}

	public int count(String search_option, String search) {
		int result = 0;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("search", search);
			result = session.selectOne("rebook.search_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public List<ReBookDTO> list(int start, int end) {
		List<ReBookDTO> list = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("rebook.list", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return list;
	}

	public int count() {
		int result = 0;
		SqlSession 	session = MybatisManager.getInstance().openSession();
		try {
			result = session.selectOne("rebook.count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return result;
	}
}