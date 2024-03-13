package member;

import java.sql.ResultSet;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;


public class MemberDAO<SqlSessionTemplate> {

	private SqlSession dataFactory;
	private Object sql;

	// 회원가입
	public void insert_join(MemberDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.insert("member.insert_join", dto);
		session.commit();
		session.close();
	}

	// 회원 조회
	public MemberDTO detailMember(String mId) {
		SqlSession session = MybatisManager.getInstance().openSession();
		MemberDTO dto = session.selectOne("member.detail_member", mId);
		session.close();
		return dto;
	}

	// 회원정보 수정
	public void edit_memberInfo(MemberDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		session.update("member.edit_memberInfo", dto);
		session.commit();
		session.close();
	}

	public int checkId(String mId) {
		SqlSession session = MybatisManager.getInstance().openSession();
		int cnt = session.selectOne("member.id_check", mId);
		session.close();
		return cnt;
	}
	

}
	

