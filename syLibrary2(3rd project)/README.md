# 📚 3rd/Semi project - 도서관 웹v.2 Spring 프로젝트
본 프로젝트는 국비지원 훈련과정 중 진행한 세번째 팀 프로젝트입니다.
<br/>
<br/>
<br/>
* * *
## 📑 목차
[__1. 프로젝트 개요__](#-프로젝트-개요)
   - [주제 및 목표](#-주제-및-목표)
   - [팀 구성 및 사용기술](#-팀-구성-및-사용기술)
<br/>
  
[__2. 주요 업데이트 사항__](#-주요-업데이트-사항)
   - [키워드 자동완성](#-키워드-자동완성)
   - [추천도서 탭](#-추천도서-탭)
   - [도서검색](#-도서검색)
   - [희망도서 신청](#-희망도서-신청)
   - [도서대출 신청](#-도서대출-신청)
<br/>
    
[__3. 프로젝트 후기 및 발표자료__](#-후기)
<br/>
🔗 [프레젠테이션 자료](https://docs.google.com/presentation/d/1EiQ5zPQsIVHS_wUwzLL1DPvhh02L0ezI-vCAWCXQWTE/edit?usp=sharing)
<br/>
<br/>
<br/>

* * *

## 📌 프로젝트 개요
#### 📅 기간
2024.04.01 ~ 2024.04.19 (3주)

- 1주차 : 개별 담당 영역 스프링 프로젝트로 리팩토링. 1차 기능 점검 후 추가개발 요소, 수정보완사항 등을 바탕으로 회의 진행
- 2주차 : 에러 수정 및 기능 개선, 추가 기능 개발 작업 진행
- 3주차 : 2차 기능 테스트 및 개발작업 마무리. 발표자료 업데이트
<br/>

#### 🖍 주제 및 목표
__[주제]__
  - 도서관 및 도서통합관리 웹
<br/>

__[목표]__
1. 2차 프로젝트(도서관 웹사이트 JSP 프로젝트)를 Spring boot를 활용, MVC 패턴에 기반한 웹 응용 프로그램으로 리팩토링	
2. 프레젠테이션 이후의 피드백을 반영하여 추가기능 개발 및 기능 개선
3. 협업 툴로써 Git, GitHub 도입하여 기본 개념 및 명령어 숙지
<br/>

#### 👥 팀 구성 및 사용기술
__[팀 구성]__
![team1](https://github.com/mindyhere/Team-Projects/assets/147589193/8228ab18-f06f-4fd4-a12b-ef42baccb520 "개인별구현기능")
<br/>

__[사용기술 및 개발환경]__
- OS : Windows11
- Tools  :  Spring Tool Suite 4, SQL Developer, Git, GitHub
- Front-end  :  HTML/CSS, Javascript
- Back-end  :  JDK21, OracleDB 23.1.1, Spring Boot
- Library  :  Lombok 1.18.30, MyBatis 3.5.15, Json, Jquery 3.7.1, JSTL, Ajax, Bootstrap 5.3, Sweetalert2, Chart.js 4.4.0, Apache Tomcat 10.1.19
<br/>
<br/>
<br/>

* * *

## 🙋🏻‍♀ 주요 업데이트 사항
#### __🪄 키워드 자동완성__
![autocomplete](https://github.com/mindyhere/Team-Projects/assets/147589193/99666fe1-5771-4cbb-92c2-cf7f9519a15f "autocomplete")

- JQuery의 autocomplete 기능을 활용해 검색어 자동완성 기능 추가(도서명, 저자, 출판사로 빠른 조회 가능)
- 기본제공 레이아웃에서 커스텀하여 완성
<details>
	<summary>코드보기</summary>

	```javascript
 	$("input[type='text']").autocomplete({  // 키워드 입력란. jQuery의 autocomplete함수 활용
		source: function (request, response) {
			$.ajax({
				url: "/user/search/autocomplete",  // 백그라운드에서 처리
				data: {"keyword": $("#keyword").val()},
				success: function (data) {
					response(
						$.map(data.arrResult, function (item) {  // 조회 결과목록을 json형태로 받아와 처리
							return {
								label: item.RESULT,
								value: item.RESULT,
							};
						})
					);
				}
			});
		}, 
		focus: function(event, ui) {
			return false;
		},
		select: function(event, ui) {
		},
		minLength: 1,
		delay: 200,
		autuFocus: true
	});
 	```

	```java
 	// SearchController.java
 	@ResponseBody
	@RequestMapping("autocomplete")
	public Map<String, Object> autocomplete(@RequestParam(name = "keyword", defaultValue = "") String keyword) {
		Map<String, Object> params = new HashMap();
		List<Map<String, Object>> arrResult = new ArrayList<>();  // 결과데이터를 담을 list 선언
		params.put("keyword", keyword);

		params.put("searchOpt", "B_NAME");
		arrResult.addAll(searchDao.autocomplete(params));  // 키워드:도서명으로 조회

		params.put("searchOpt", "B_AUTHOR");
		arrResult.addAll(searchDao.autocomplete(params));  // 키워드:저자로 조회

		params.put("searchOpt", "B_PUB");
		arrResult.addAll(searchDao.autocomplete(params));  // 키워드:출판사로 조회

		params.put("arrResult", arrResult);  // 파라미터에 담아 화면단으로 반환
		return params;
	}
 	```
</details> 
<br/>

#### __🎖 추천도서 탭__
![edit1](https://github.com/mindyhere/Team-Projects/assets/147589193/4ed58ced-dd68-45e6-987c-f9918b80bf90 "recommend")

- 대출이 많은 책 : 테이블 외부조인(대출테이블, 예약테이블)과 뷰를 활용해 대출 또는 예약이 많은 상위 5권을 페이지에 출력. SQL문을 수정하여 간결한 구조로 변경
<details>
	<summary>코드보기</summary>
	
 	```OracleDB
	CREATE OR REPLACE VIEW recmd_pop
	as
	  select A.*
	  from (
		select l_bookid b_id,
		  count(l_bookid) cnt,
		  (select b_name from sl_book where b_id = l_bookid) b_name,
		  (select b_author from sl_book where b_id = l_bookid) b_author,
		  (select b_url from sl_book where b_id = l_bookid) b_url
		from lo_book l FULL OUTER JOIN re_book r
		ON L_BOOKID=R_BOOKID
		group by l_bookid
		order by cnt desc) A
	  where rownum <=5;
	  ```
</details>
<br/>

#### __🔎 도서검색__
![search101](https://github.com/mindyhere/Team-Projects/assets/147589193/731cc866-8697-4eaf-bc0b-f3076118632d "통합검색")

- 사이드바에서 집계결과 재검색 시 사용하는 함수 업데이트
- 기존에 개별함수로 나누었던 것을 switch문을 사용해 간소화 : 페이지이동, 결과보기 방식을 모두 Ajax로 처리하면서 과정을 파악하기에 좋지 않다고 판단하였고, 해당 부분과 관련된 코드를 간소화하여 보다 쉽게 이해할 수 있도록 변경
<details>
	<summary>코드보기</summary>
	
 	```javascript
	// searchResult.jsp
	function searchBy(page, searchOpt) {
		let keyword = $("input[name=keyword]").val();
		let view= $("input[name=viewOpt]:checked").val();
		let params, count, txt;
		
		switch (searchOpt) {
		case "name":
			count = ${cntRec.cntName};
			txt = "결과 내 검색 - <span>[제목]:"+keyword+"&nbsp;[저자]:&nbsp;&nbsp;[발행처]:&nbsp;&nbsp;</span>에 대한 검색결과, 총 <span>"+count+"</span> 건";
			params={"b_name":keyword, "searchOpt":searchOpt, "view":view, "count":count, "page":page};
			break;
		case "author":
			count=${cntRec.cntAuthor};
			txt = "결과 내 검색 - <span>[제목]:&nbsp;&nbsp;[저자]:"+keyword+"&nbsp;[발행처]:&nbsp;&nbsp;</span>에 대한 검색결과, 총 <span>"+count+"</span> 건";
			params={"b_author":keyword, "searchOpt":searchOpt, "view":view, "count":count, "page":page};
			break;
		case "pub":
			count=${cntRec.cntPub};
			txt = "결과 내 검색 - <span>[제목]:&nbsp;&nbsp;[저자]:&nbsp;&nbsp;[발행처]:"+keyword+"&nbsp;</span>에 대한 검색결과, 총 <span>"+count+"</span> 건";
			params={"b_pub":keyword, "searchOpt":searchOpt, "view":view, "count":count, "page":page};
			break;
		}
		
		if (count !== 0) {
			$("#text").html(txt);
			$.ajax({
				url:"/user/search/searchBy",
				data:params,
				success:function(result){
					$("#section-resultList").html(result);
				}
			});
		}
	}
 	```

  	```java
   	//SearchController.java
 	@RequestMapping("searchBy")
	public ModelAndView searchBy(@RequestParam(name = "searchOpt") String option,
			@RequestParam(name = "b_name", defaultValue = "") String b_name,
			@RequestParam(name = "b_author", defaultValue = "") String b_author,
			@RequestParam(name = "b_pub", defaultValue = "") String b_pub,
			@RequestParam(name = "view", defaultValue = "view1") String view,
			@RequestParam(name = "page", defaultValue = "1") int page, @RequestParam(name = "count") int count) {
		String resultPage = "";
  		// 결과 보기방식 페이지(화면단) 설정
		if (view.equals("view1")) {
			resultPage = "/user/search/view1";
		} else if (view.equals("view2")) {
			resultPage = "/user/search/view2";
		}
		// 페이지 나누기 적용
		PageUtil pageInfo = new PageUtil(count, page);
		int start = pageInfo.getPageBegin();
		int end = pageInfo.getPageEnd();

		List<BookDTO> list = searchDao.detailSearch(b_name, b_author, b_pub, start, end);
		ModelAndView mav = new ModelAndView();
		mav.setViewName(resultPage);
		mav.addObject("list", list);
		mav.addObject("stateinfo", searchDao.listState(list));
		mav.addObject("cntRec", searchDao.countRecords(b_name, b_author, b_pub));
		mav.addObject("count", count);
		mav.addObject("b_name", b_name);
		mav.addObject("b_author", b_author);
		mav.addObject("b_pub", b_pub);
		mav.addObject("page", pageInfo);
		mav.addObject("view", view);
		mav.addObject("option", option);
		return mav;
	}
   	```
 </details>
<br/>

#### __📖 희망도서 신청__
![request](https://github.com/mindyhere/Team-Projects/assets/147589193/ec6c32e5-bbc9-4c45-b67e-2b2f070c61d3 "희망도서신청")

- 도서관 회원으로부터 희망도서를 신청받는 기능 추가
- 알라딘 도서검색 API활용. 팝업창에서 원하는 도서 검색 후 JSON 데이터를 input 태그에 담아 부모창(희망도서 신청서 작성 페이지)으로 데이터 전달
- 정상처리 시 희망도서 테이블에 데이터 insert 및 신청현황 페이지로 링크 이동
<details>
	<summary>코드보기</summary>

	```javascript
 	// popup.jsp

	function bookInfo(success, data) {  // 콜백함수
		const items = data.item;
		let str = "";
		if (data.totalResults > 0) {
			for (i = 0; i < items.length; i++) {
				let title = (!items[i].title)? "-" : items[i].title;
				let cover = (!items[i].cover)? "-" : items[i].cover;
				let author = (!items[i].author)? "-" : items[i].author;
				let publisher = (!items[i].publisher)? "-" : items[i].publisher;
				let isbn13 = (!items[i].isbn13)? "-" : items[i].isbn13;
				let description = (!items[i].description)? "-" : modify(items[i].description);  // 줄거리 안의 특수문자 처리
				let pubDate = (!items[i].pubDate)? "-" : items[i].pubDate.substr(0, 4);  // 발행일에서 연도만 가져와 세팅
				let categoryName = (!items[i].categoryName)? "-" : items[i].categoryName.split(">", 2);  // 도서분류 중 세부 분류 1개만 뽑아서 세팅
				let link = (!items[i].link)? "-" : items[i].link;
				
				let jsonArr = new Array();  // 결과 리스트
				jsonArr.push({
					"idx" : i + "",
					"h_name" : title,
					"h_url" : cover,
					"h_author" : author,
					"h_pub" : publisher,
					"h_isbn" : isbn13,
					"h_description" : description,
					"h_year" : pubDate,
					"h_category" : setCategoryName(categoryName),
					"h_link" : items[i].link
				});
				// console.log(jsonArr);
    				// 팝업창에 결과 리스트 반복처리
				 // 각 도서정보를 json으로 묶고, 스트링으로 변환하여 input 태그에 저장 - 개별항목 클릭 시 부모창에 도서정보를 전달하기 위함
				str += "<tr><td><a href='#' onclick='confirm(" + i + ")'>"
						+ items[i].title + "</a><br>(" + items[i].author
						+ "&nbsp;|&nbsp;" + items[i].publisher + "&nbsp;|&nbsp;"
						+ items[i].pubDate.substr(0, 4) + ")<input id='" + i
						+ "' type='hidden' value='"
						+ JSON.stringify(jsonArr) + "'></td></tr>";
			}
		} else {
			Swal.fire({
				icon: "info",
				title: "Check!",
				html: "찾으시는 검색결과 없습니다.<br>검색어를 다시 한번 확인해주세요.",
				confirmButtonText: "OK"
			});
		}
		$("#result").append(str);
	}

	function search() {  // 알라딘 도서정보 검색
		let keyword = $("#keyword").val();
	
		if (keyword.trim().length >= 2) {
			$('#result > tr > td').remove();
			let url = "http://www.aladin.co.kr/ttb/api/ItemSearch.aspx?ttbkey=ttbabout_kei2155001&Query="
					+ keyword
					+ "&QueryType=Keyword&&MaxResults=100&SearchTarget=Book&Sort=Title&cover=Big&output=js&callBack=bookInfo";
	
			$.ajax({
				url : url,
				async : false,
				dataType : "jsonp",
				jsonp : "bookInfo"
			});
		} else {
			Swal.fire({
				icon: "info",
				title: "Check!",
				html: "검색 키워드는 2글자 이상 입력해주세요.",
				confirmButtonText: "OK"
			});
		}
	}

	function confirm(i) {  // 부모창으로 신청도서 데이터를 전달해 뿌려줌
		const obj = JSON.parse(document.getElementById(i).value);
		const data = obj[0];
		
		opener.document.getElementById("h_url").src = data.h_url
		opener.document.getElementById("h_name").value = data.h_name
		opener.document.getElementById("h_author").value = data.h_author
		opener.document.getElementById("h_pub").value = data.h_pub
		opener.document.getElementById("h_year").value = data.h_year
		opener.document.getElementById("h_category").value = data.h_category
		opener.document.getElementById("data").value = document.getElementById(i).value
		window.close();
	}
 	```
</details>
<br/>

#### __🙋 도서대출 신청__
![checkout1](https://github.com/mindyhere/Team-Projects/assets/147589193/0fa4eede-7b5f-4c99-af39-926bcad769b7 "도서대출신청")

- 대출 신청자의 도서대출 가능여부를 확인하는 과정과 관련된 프로시저 및 처리코드 개선 및 회원 등급별 도서대출 기준 반영
- 예약도서확인 및 대출신청 관련 기능 개선
  <details>
	<summary>코드보기</summary>

	```java
 	// CheckoutController.java
 	@GetMapping("{b_id}")
	public String checkMloan(@PathVariable(name = "b_id") int b_id, HttpSession session) {
		String m_id = (String) session.getAttribute("mId");
		Map<String, Object> param = new HashMap();
		param.put("userid", m_id);
		checkoutDao.checkMloan(param);  // 신청자의 도서대출 가능여부 확인 : 프로시저 실행 후 반환값(1=대출가능상태/0=대출불가상태)이 파라미터에 저장됨

		String resultPage = "";
		switch (param.get("p_result").toString()) {
		case "1":  // 대출가능 상태일 경우,
			Map<String, Object> map = new HashMap<>();
			map.put("m_id", m_id);
			map.put("b_id", b_id);
			int result = checkoutDao.duplicate(map) > 0 ? 0 : 1;  // 중복신청인지 검사
			if (checkoutDao.duplicate(map) > 0) {
				resultPage = "redirect:fail";
			} else {
				resultPage = "redirect:" + b_id + "/insert";
			}
			break;
		case "0":  // 대출불가 생태일 경우,
			resultPage = "redirect:fail";
			break;
		}
		return resultPage;
	}

	@Transactional
	@ResponseBody
	@GetMapping("{b_id}/insert")  // 대출테이블에 insert 처리
	public String insert(@PathVariable(name = "b_id") int b_id, HttpSession session) {
		String m_id = (String) session.getAttribute("mId");
		Map<String, Object> map = new HashMap<>();
		map.put("m_id", m_id);
		map.put("b_id", b_id);
		checkoutDao.insert(map); 
		String result = "신청완료";
		return result;
	}
 	```
</details>
<br/>
<br/>
<br/>

* * *
 
## 🎓 후기
#### __🛠️ 피드백 반영 및 개선사항__
- 기간부족으로 기존에 구현하지 못했던 검색어 자동완성 기능 추가
- 희망도서와 관련된 추가 기능 구현 ▶ 오픈API의 적용 및 이용자는 희망도서 신청 및 취소 서비스를 이용할 수 있고, 관리자는 이용자가 신청한 희망도서의 상태를 변경 가능하도록 추가 기능 개발완료
- Git을 도입함으로써 협업 환경에 적응하고 버전관리 및 상호간의 작업 진행현황을 공유하기가 용이
<br/>
