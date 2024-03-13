package login;

import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class LoginDTO {
	private int m_no;
	private String m_id;
	private String m_passwd;
	private String m_name;
	private String m_tel;
	private String m_address;
	private String m_email;
	private Date m_birth_date;
	private String m_url;
	private Date m_year;
	private int m_loan;
}
