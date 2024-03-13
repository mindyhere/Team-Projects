package recommend;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import admin.book.BookDTO;
import sqlmap.MybatisManager;

public class RecmdDAO {
	// 사용자 탭 선택 → 목록 가져오기
	public List<BookDTO> getList(String option) {
		SqlSession session = null;
		List<BookDTO> list = new ArrayList<>();
		try {
			session = MybatisManager.getInstance().openSession();
			switch (option) {
			case "opt1":
				list = session.selectList("recommend.opt1");
				break;

			case "opt2":
				list = session.selectList("recommend.opt2");

				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public List<Map<String, Object>> getList() {
		SqlSession session = null;
		List<Map<String, Object>> list = new ArrayList<>();
		try {
			session = MybatisManager.getInstance().openSession();
			list = session.selectList("recommend.opt3");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	public String insert(String a_id, int b_id) {
		SqlSession session = null;
		String result = "";
		try {
			session = MybatisManager.getInstance().openSession();
			int preCount = session.selectOne("recommend.pre_count");
			int preCheck = session.selectOne("recommend.pre_check", b_id);
			if (preCount < 5 && preCheck == 0) {
				Map<String, Object> map = new HashMap<>();
				map.put("a_id", a_id);
				map.put("b_id", b_id);
				session.insert("recommend.recmd_insert", map);
				session.commit();
				result = "등록되었습니다.";
			} else {
				result = "Not possible";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	// 전체 레코드 삭제
	public String delete(String option) {
		SqlSession session = null;
		String result = "";
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("option", option);
			session.delete("recommend.delete", map);
			session.commit();
			result = "삭제되었습니다.";
		} catch (Exception e) {
			result = "Not possible";
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	// 선택 레코드 삭제
	public String delete(String option, int idx) {
		SqlSession session = null;
		String result = "";
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("option", option);
			map.put("idx", idx);
			session.delete("recommend.delete", map);
			session.commit();
			result = "삭제되었습니다.";
		} catch (Exception e) {
			e.printStackTrace();
			result = "Not possible";
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
}
