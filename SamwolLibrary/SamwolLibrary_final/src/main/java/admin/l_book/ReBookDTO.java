package admin.l_book;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ReBookDTO {
	private int r_num;
	private int r_memno;
	private int r_bookid;
	private String r_regdate;
	private int r_reservation;
	private String r_loan_yn;
	private String b_url;
	private int b_id;
	private int b_year;
	private String b_name;
	private String b_author;
	private String b_pub;
	private int m_no;
	private int re_book_cnt;
	private String m_id;
	private String m_name;
}
