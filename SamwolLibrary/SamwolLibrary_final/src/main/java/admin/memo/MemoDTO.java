package admin.memo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MemoDTO {
	private int me_rownum;
	private String me_a_id;
	private String me_memo;
	private String me_post_date;
	private String a_id;
	private String a_name;
}
