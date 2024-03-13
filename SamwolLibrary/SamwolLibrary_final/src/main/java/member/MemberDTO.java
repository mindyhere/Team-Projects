package member;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MemberDTO {
	private int m_no;
	private String m_id;
	private String m_passwd;
	private String m_name;
	private String m_tel;
	private String m_zip_no;
	private String m_address;
	private String m_detail_address;
	private String m_email;
	private String m_birth_date;
	private String m_img;
	private String m_year;
	private int m_loan;

	public MemberDTO() {}
	
	public MemberDTO(String m_name, String m_id, String m_birth_date, String m_tel, String m_email, String m_address, String m_img, String m_year, String m_zip_no, String m_detail_address) {
		super();
		this.m_name = m_name;
		this.m_id = m_id;
		this.m_birth_date = m_birth_date;
		this.m_tel = m_tel;
		this.m_email = m_email;
		this.m_address = m_address;
		this.m_img = m_img;
		this.m_year = m_year;
		this.m_zip_no = m_zip_no; 
		this.m_detail_address = m_detail_address;
	}
}
