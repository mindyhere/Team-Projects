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
public class RecordDTO {
	private int l_num;
	private int l_bookid;
	private String b_name;
	private String b_author;
	private String b_pub;
	private String m_id;
	private String l_lodate;
	private String l_retdate;
	private String l_return_yn;
	private String l_over;
}
