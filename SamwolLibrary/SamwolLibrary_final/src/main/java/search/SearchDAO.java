package search;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import admin.book.BookDTO;
import sqlmap.MybatisManager;

public class SearchDAO {

	// 키워드로 통합검색(도서명, 작가, 출판사)
	public List<BookDTO> totSearch(String keyword, int start, int end) {
		SqlSession session = null;
		List<BookDTO> list = new ArrayList<>();

		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("keyword", keyword);
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("search.totSearch", map);

			for (BookDTO dto : list) {
				String b_name = dto.getB_name();
				String b_author = dto.getB_author();
				String b_pub = dto.getB_pub();
				// 키워드 강조(폰트 컬러)
				b_name = b_name.replace(keyword, "<span style='color:crimson'>" + keyword + "</span>");
				b_author = b_author.replace(keyword, "<span style='color:crimson'>" + keyword + "</span>");
				b_pub = b_pub.replace(keyword, "<span style='color:crimson'>" + keyword + "</span>");
				dto.setB_name(b_name);
				dto.setB_author(b_author);
				dto.setB_pub(b_pub);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	// 추천도서 편집페이지에서 검색
	public List<BookDTO> totSearch(String keyword) {
		SqlSession session = null;
		List<BookDTO> list = new ArrayList<>();
		try {
			session = MybatisManager.getInstance().openSession();
			list = session.selectList("search.simpleSearch", keyword);
			for (BookDTO dto : list) {
				String b_name = dto.getB_name();
				String b_author = dto.getB_author();
				String b_pub = dto.getB_pub();
				// 키워드 강조(폰트 컬러)
				b_name = b_name.replace(keyword,
						"<span style='color:crimson; font-weight:bold;'>" + keyword + "</span>");
				b_author = b_author.replace(keyword,
						"<span style='color:crimson; font-weight:bold;'>" + keyword + "</span>");
				b_pub = b_pub.replace(keyword, "<span style='color:crimson; font-weight:bold;'>" + keyword + "</span>");
				dto.setB_name(b_name);
				dto.setB_author(b_author);
				dto.setB_pub(b_pub);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	// 상세검색(도서명, 작가, 출판사)
	public List<BookDTO> detailSearch(String b_name, String b_author, String b_pub, int start, int end) {
		SqlSession session = null;
		List<BookDTO> list = new ArrayList<>();

		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("b_name", b_name);
			map.put("b_author", b_author);
			map.put("b_pub", b_pub);
			map.put("start", start);
			map.put("end", end);
			list = session.selectList("search.detailSearch", map);
			for (BookDTO dto : list) {
				String name = dto.getB_name();
				String author = dto.getB_author();
				String pub = dto.getB_pub();
				// 키워드 강조(폰트 컬러)
				if (b_name != "") {
					name = name.replace(b_name, "<span style='color:crimson'>" + b_name + "</span>");
				}
				dto.setB_name(name);
				
				if (b_author != "") {
					author = author.replace(b_author, "<span style='color:crimson'>" + b_author + "</span>");
				}
				dto.setB_author(author);
				
				if (b_pub != "") {
					pub = pub.replace(b_pub, "<span style='color:crimson'>" + b_pub + "</span>");
				}
				dto.setB_pub(pub);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return list;
	}

	// 항목별 레코드 개수 구하기
	public Map<String, Object> countRecords(String keyword) {
		int cntName, cntAuthor, cntPub = 0;
		SqlSession session = null;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			session = MybatisManager.getInstance().openSession();
			String b_name = keyword;
			cntName = session.selectOne("search.cntName", b_name);
			String b_author = keyword;
			cntAuthor = session.selectOne("search.cntAuthor", b_author);
			String b_pub = keyword;
			cntPub = session.selectOne("search.cntPub", b_pub);
			map.put("cntName", cntName);
			map.put("cntAuthor", cntAuthor);
			map.put("cntPub", cntPub);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return map;
	}

	public Map<String, Object> countRecords(String b_name, String b_author, String b_pub) {
		SqlSession session = null;
		int cntName = 0;
		int cntAuthor = 0;
		int cntPub = 0;
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			session = MybatisManager.getInstance().openSession();
			if (b_name != "") {
				cntName = session.selectOne("search.cntName", b_name);
			}
			map.put("cntName", cntName);
			if (b_author != "") {
				cntAuthor = session.selectOne("search.cntAuthor", b_author);
			}
			map.put("cntAuthor", cntAuthor);
			if (b_pub != "") {
				cntPub = session.selectOne("search.cntPub", b_pub);
			}
			map.put("cntPub", cntPub);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}

		return map;
	}

	// resultCount함수 오버로딩 : 검색 결과 레코드 수 계산
	public int resultCount(String option, String keyword) {
		int result = 0;
		SqlSession session = null;

		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("option", option);
			map.put("keyword", keyword);
			result = session.selectOne("search.resultCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	public int resultCount(String option, String b_name, String b_author, String b_pub) {
		int result = 0;
		SqlSession session = null;

		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("option", option);
			map.put("b_name", b_name);
			map.put("b_author", b_author);
			map.put("b_pub", b_pub);
			result = session.selectOne("search.resultCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	// 도서 상세정보 가져오기
	public BookDTO showDetails(int b_id) {
		BookDTO dto = null;
		SqlSession session = null;
		try {
			session = MybatisManager.getInstance().openSession();
			dto = session.selectOne("book.edit", b_id);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return dto;
	}

}
