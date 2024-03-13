package checkout;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import admin.book.BookDTO;
import sqlmap.MybatisManager;

public class CheckoutDAO {
	// (b_id 1개 당)도서 대출가능여부(소장상태): 대여가능(Y) or 대여불가 (N)
	public String isAvailable(int b_id) {
		SqlSession session = null;
		String state = "";
		int loCount = 0;
		int reCount = 0;
		try {
			session = MybatisManager.getInstance().openSession();
			int b_amount = 3;
			loCount = session.selectOne("checkout.loCount", b_id);
			reCount = session.selectOne("checkout.reCount", b_id);
			if (b_amount > (loCount+reCount)) {
				state = "y";
			} else {
				state = "n";
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return state;
	}

	// 회원의 대출가능여부: mloan 상태 & 이미 대출상태인 책 확인
	public int checkMloan(String m_id, int b_id) {
		SqlSession session = null;
		int check = 1; // 초기화. 1(대출가능) or 0(대출불가)
		try {
			session = MybatisManager.getInstance().openSession();
			// 회원의 대출가능여부: 1(대출가능) or 0(대출불가, 5권 모두 대출중)
			int m_loan = session.selectOne("checkout.check_mLoan", m_id);
			switch (m_loan) {
			case 1: // 동일한 책을 기존에 대출중인지 확인
				Map<String, Object> map = new HashMap<>();
				map.put("m_id", m_id);
				map.put("b_id", b_id);
				int duplicate = session.selectOne("checkout.check_duplicate", map);
				check = duplicate > 0 ? 0 : 1;
				break;
			case 0:
				check = 0;
				break;
			}
		} catch (Exception e) {
			e.printStackTrace();
			check = 0;
		} finally {
			if (session != null)
				session.close();
		}
		return check;
	}

	// 검색도서목록, 대여가능여부 리스트
	public List<Map<String, Object>> listState(List<BookDTO> list) {
		SqlSession session = null;
		List<Map<String, Object>> states = new ArrayList<>();
		try {
			session = MybatisManager.getInstance().openSession();
			CheckoutDAO dao = new CheckoutDAO();
			for (BookDTO dto : list) {
				Map<String, Object> map = new HashMap<String, Object>();
				String state = dao.isAvailable(dto.getB_id());
				map.put("b_id", dto.getB_id());
				map.put("state", state);
				states.add(map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return states;
	}

	// (m_id 1개 당) 현재 대출가능한 도서 개수
	public int cntUserLo(String m_id) {
		SqlSession session = null;
		int cnt = 5;
		try {
			cnt = cnt - Integer.parseInt(session.selectOne("checkout.cntUserLo", m_id));
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (session != null)
				session.close();
		}
		return cnt;
	}

	// 도서 대출 신청(db insert)
	public String checkout(String m_id, int b_id) {
		SqlSession session = null;
		String result = "";
		try {
			session = MybatisManager.getInstance().openSession();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("m_id", m_id);
			map.put("b_id", b_id);
			session.insert("checkout.insert_Lobook", map); // 대출 Lo_book insert
			session.update("checkout.call_CheckLoan", m_id);
			session.commit();
			result = "신청이 완료되었습니다";
		} catch (Exception e) {
			e.printStackTrace();
			result = "Not possible";
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}

	// 가장 빠른 반납예정일
	public String fastRetdate(int b_id) {
		SqlSession session = null;
		String state = "";
		String result = "";

		try {
			session = MybatisManager.getInstance().openSession();
			CheckoutDAO dao = new CheckoutDAO();
			state = dao.isAvailable(b_id);
			if (state.equals("n")) {
				result = session.selectOne("checkout.retDate", b_id);
			}
		} catch (Exception e) {
			e.printStackTrace();
			result = "";
		} finally {
			if (session != null)
				session.close();
		}
		return result;
	}
}
