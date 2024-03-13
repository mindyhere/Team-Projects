package review;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class ReviewDAO {
	// 도서별 리뷰 목록 조회
	public List<Map<String, Object>> getReviews(int b_id) {
		SqlSession session = null;
		List<Map<String, Object>> reviews = null;
		try {
			session = MybatisManager.getInstance().openSession();
			if (b_id < 0) {
				String keyword="";
				reviews = session.selectList("review.searchAll", keyword);
			} else {
				reviews = session.selectList("review.getReviews", b_id);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return reviews;
	}

	public String insert(Map<String, Object> map) {
		SqlSession session = null;
		String result = "";
		try {
			session = MybatisManager.getInstance().openSession();
			String contents = (String) map.get("contents");
			contents = contents.replace("<", "&lt;");
			contents = contents.replace(">", "&gt;");
			contents = contents.replace("  ", "&nbsp;&nbsp;");
			map.put("contents", contents);
			session.insert("review.review_insert", map);
			session.commit();
			session.close();
			result = "등록되었습니다.";
		} catch (Exception e) {
			e.printStackTrace();
			result = "Not possible";
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	// 회원이 삭제할 경우
	public String delete(Map<String, Object> map) {
		SqlSession session = null;
		String result = "";
		try {
			session = MybatisManager.getInstance().openSession();
			session.delete("review.user_delete", map);
			session.commit();
			session.close();
			result = "삭제되었습니다.";
		} catch (Exception e) {
			e.printStackTrace();
			result = "Error";
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	// 관리자가 삭제할경우
	public String delete(int idx) {
		SqlSession session = null;
		String result = "";
		try {
			session = MybatisManager.getInstance().openSession();
			session.delete("review.admin_delete", idx);
			session.commit();
			session.close();
			result = "삭제되었습니다.";
		} catch (Exception e) {
			e.printStackTrace();
			result = "Error";
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public List<Map<String, Object>> search(String searchOpt, String keyword) {
		SqlSession session = null;
		List<Map<String, Object>> list = null;
		try {
			if (searchOpt.equals("all")) {
				session = MybatisManager.getInstance().openSession();
				list = session.selectList("review.searchAll", keyword);
			}else  {
				session = MybatisManager.getInstance().openSession();
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("searchOpt", searchOpt);
				map.put("keyword", keyword);
				list = session.selectList("review.search", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}
}
