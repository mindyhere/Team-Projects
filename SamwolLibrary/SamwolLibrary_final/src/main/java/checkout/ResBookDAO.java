package checkout;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import admin.l_book.ReBookDTO;
import sqlmap.MybatisManager;

public class ResBookDAO {

	public void insert_resbook(Map<String, Object> map) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.insert("res_book.insert_book", map);
		session.commit();
		session.close();
	}

	public List<ReBookDTO> myReBook(String r_memno) {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<ReBookDTO> myReBook = session.selectList("res_book.myReBook", r_memno);

		session.close();
		return myReBook;
	}

	public int recheck_book(Map<String, Object> map) {
		SqlSession session = MybatisManager.getInstance().openSession();
		int reCnt = session.selectOne("res_book.recheck_book", map);
		session.close();
		return reCnt;
	}

	public int recheck_duplicate(Map<String, Object> map) {
		SqlSession session = MybatisManager.getInstance().openSession();
		int dupCnt = session.selectOne("res_book.rechech_duplicate", map);
		session.close();
		return dupCnt;
	}

	public void res_delete(Map<String, Object> map) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.delete("res_book.res_delete", map);
		session.commit();
		session.close();
	}

	public void myResDelete(Map<String, Object> map) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.delete("res_book.myres_delete", map);
		session.commit();
		session.close();
	}
}
