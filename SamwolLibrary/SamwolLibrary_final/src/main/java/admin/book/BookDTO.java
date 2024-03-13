package admin.book;

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
public class BookDTO {
	private int b_id;
	private String b_name;
	private String b_author;
	private String b_pub;
	private int b_year;
	private String b_category;
	private String b_isbn;
	private int b_amount;
	private String b_url;
	private String b_description;
}
