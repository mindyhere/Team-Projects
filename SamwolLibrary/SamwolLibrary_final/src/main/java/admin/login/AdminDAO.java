package admin.login;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import admin.chart.ChartDTO;
import admin.memo.MemoDTO;
import sqlmap.MybatisManager;

public class AdminDAO {
	public String login(AdminDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String a_name = session.selectOne("admin_login.login",dto);
		session.close();
		return a_name;
	}

	public List<Map<String, Object>> lo_chart() {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<Map<String, Object>> map = new ArrayList<Map<String, Object>>();
		try {
			session = MybatisManager.getInstance().openSession();
			map = session.selectList("admin_login.loanChart");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return map;
	}

	public List<Map<String, Object>> ct_chart() {
		SqlSession session = MybatisManager.getInstance().openSession();
		List<Map<String, Object>> map = session.selectList("admin_login.ct_Chart");
		session.close();
		return map;
	}
}
