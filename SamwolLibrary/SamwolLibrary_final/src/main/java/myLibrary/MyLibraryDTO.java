package myLibrary;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class MyLibraryDTO {
	private int m_no;
	private String m_id;
	private String m_name;
	private String m_tel;
	private String m_email;
	private String m_img;
	private String m_year;
	private String b_url;
	private String b_name;
	private String b_author;
	private String b_pub;
	private String b_year;
	private String b_isbn;
	private String b_category;
	private int l_memno;
	private int l_bookid;
	private String l_lodate;
	private String l_retdate;
	private String l_complete;
	private int lo_book_cnt;
	private int re_book_cnt;
	private int total_cnt;
}
