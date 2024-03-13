package admin.memo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import member.MemberDTO;
import common.PageUtil;
import sqlmap.MybatisManager;

public class MemoDAO {

	public List<MemoDTO> list(int start, int end) {
		SqlSession session = MybatisManager.getInstance().openSession();
		Map<String, Object> map = new HashMap<String,Object>();
		map.put("start", start);
		map.put("end", end);
		List<MemoDTO> items = session.selectList("memo.list",map);
		session.close();
		return items;
	}

	public void insert(MemoDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String memo = dto.getMe_memo();
		memo = memo.replace("<", "&lt;");
		memo = memo.replace(">", "&gt;");
		memo = memo.replace("  ","&nbsp;&nbsp;");
		dto.setMe_memo(memo);
		session.insert("memo.insert", dto);
		session.commit();
		session.close();		
	}

	public void delete(int me_rownum) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.delete("memo.delete", me_rownum);
		session.commit();
		session.close();		
	}

	public void update(MemoDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.update("memo.update", dto);
		session.commit();
		session.close();
		
	}

	public int count() {
		int result = 0;
		SqlSession 	session = MybatisManager.getInstance().openSession();
		try {
			result = session.selectOne("memo.count");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return result;
	}

	public MemoDTO search(int me_rownum) {
		SqlSession session = MybatisManager.getInstance().openSession();
		MemoDTO dto = new MemoDTO();
		try {
			dto = session.selectOne("memo.search", me_rownum);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(session != null)
				session.close();
		}
		return dto;
	}
}
