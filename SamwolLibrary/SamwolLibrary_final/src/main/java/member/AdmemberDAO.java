package member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class AdmemberDAO {
	public List<MemberDTO> ad_list_search(String search_option, String search, int start, int end) {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<MemberDTO> ad_items = null;
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("search", search);
			map.put("start", start);
			map.put("end", end);
			ad_items = session.selectList("member.ad_search_list", map);

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return ad_items;
	}

	public MemberDTO ad_list_detail(String m_no) {

		SqlSession session = MybatisManager.getInstance().openSession();
		MemberDTO de_list = session.selectOne("member.ad_detail", m_no);
		session.close();
		return de_list;
	}

	public int count() {
		int result = 0;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			result = session.selectOne("member.ad_p_count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public List<MemberDTO> list() {
		List<MemberDTO> list = null;
		SqlSession session = null; // sql 실행
		try {
			session = MybatisManager.getInstance().openSession();
			list = session.selectList("member.ad_p_list");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public List<MemberDTO> list(int pageStart, int pageEnd) {
		List<MemberDTO> list = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<>();
			map.put("start", pageStart);
			map.put("end", pageEnd);
			list = session.selectList("member.ad_p_list", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public int search_count(String search_option, String search) {
		int result = 0;
		SqlSession session = MybatisManager.getInstance().openSession();
		try {
			Map<String, Object> map = new HashMap<>();
			map.put("search_option", search_option);
			map.put("search", search);
			result = session.selectOne("member.ad_search_count", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
}
