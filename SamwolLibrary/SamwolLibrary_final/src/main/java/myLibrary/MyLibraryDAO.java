package myLibrary;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class MyLibraryDAO {

	public MyLibraryDTO myLibrary_list(String mId) {
		SqlSession session = MybatisManager.getInstance().openSession();
		MyLibraryDTO myLibrary = session.selectOne("myLibrary.myLibrary_list", mId);
		session.close();
		return myLibrary;
	}

	public List<MyLibraryDTO> myLoanBook(int mNo) {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<MyLibraryDTO> myLoanBook = session.selectList("myLibrary.myLoanBook", mNo);
		session.close();
		return myLoanBook;
	}

	public List<MyLibraryDTO> myHistory(int mNo) {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<MyLibraryDTO> myHistory = session.selectList("myLibrary.myHistory", mNo);
		session.close();
		return myHistory;
	}

	public int checkReservation(int bId) {
		SqlSession session = MybatisManager.getInstance().openSession();
		int reCnt = session.selectOne("myLibrary.checkReservation", bId);
		session.close();
		return reCnt;
	}

	public String checkRenewYn(Map<String, Object> map) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String renewYn = session.selectOne("myLibrary.checkRenewYn", map);
		session.close();
		return renewYn;
	}

	public void updateReturn(Map<String, Object> map) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.update("myLibrary.updateReturn", map);
		session.commit();
		session.close();
	}

	public List<Map<String, Object>> cateChart(int mNo) {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<Map<String, Object>> cateChartList = session.selectList("myLibrary.cateChart", mNo);
		session.close();
		return cateChartList;
	}

	public List<Map<String, Object>> monthChart(int mNo) {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<Map<String, Object>> monthChart = session.selectList("myLibrary.monthChart", mNo);
		session.close();
		return monthChart;
	}

	public List<Map<String, Object>> yearChart(int mNo) {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<Map<String, Object>> yearChart = session.selectList("myLibrary.yearChart", mNo);
		session.close();
		return yearChart;
	}
}
