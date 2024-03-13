package login;

import org.apache.ibatis.session.SqlSession;

import sqlmap.MybatisManager;

public class LoginDAO {

	public String loginCheck(LoginDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String mName = session.selectOne("login.loginCheck", dto);
		return mName;
	}

	public String idEmailCheck(LoginDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String mId = session.selectOne("login.searchIdEmail", dto);
		return mId;
	}

	public String idTelCheck(LoginDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String mId = session.selectOne("login.searchIdTel", dto);
		return mId;
	}

	public String pwdEmailCheck(LoginDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String mPasswd = session.selectOne("login.searchPwEmail", dto);
		return mPasswd;
	}

	public String pwdTelCheck(LoginDTO dto) {
		SqlSession session = MybatisManager.getInstance().openSession();
		String mPasswd = session.selectOne("login.searchPwTel", dto);
		return mPasswd;
	}
}
