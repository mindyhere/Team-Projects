package admin.l_book;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class LoanDTO {
	private int l_num;
	private int l_memno;
	private int l_bookid;
	private int b_id;
	private String b_name;
	private String b_author;
	private String m_no;
	private String m_id;
	private String m_name;
	private int m_loan;
	private String l_lodate;
	private String l_retdate;
	private String l_renew_yn;
	private String l_return_yn;
	private int r_bookid;
	private int r_memno;
	private int l_y;
	private int r_y;
}
