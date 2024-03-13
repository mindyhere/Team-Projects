# 📚 2nd/Semi project - 3월 도서관
본 프로젝트는 국비지원 훈련과정 중 진행한 두번째 팀프로젝트이며, 학습기록을 위해 업로드함.
<br/>
<br/>
<br/>
* * *
## 📑 목차
[__1. 프로젝트 개요__](#-프로젝트-개요)
   - [주제 및 목표](#-주제-및-목표)
   - [팀 구성 및 사용기술](#-팀-구성-및-사용기술)
<br/>
  
[__2. 주요 구현기능 설명__](#-주요-구현기능-설명)
   - [홈화면](#-홈화면)
   - [추천도서 탭](#-추천도서-탭)
   - [도서검색](#-도서검색)
   - [도서상세정보 : 페이지인쇄 및 리뷰](#-상세정보-페이지인쇄-및-리뷰)
   - [도서대출 신청](#-도서대출-신청)
   - [그 외 구현기능](#-그-외-구현기능)
<br/>
    
[__3. 프로젝트 후기 및 발표자료__](#-후기)
<br/>
🔗 [프레젠테이션 자료](https://docs.google.com/presentation/d/19Hi8HgZE-Zn88lhW7pmRSJ1mOBWTmTxJ34NunvYbvU4/edit?usp=sharing)
<br/>
<br/>
<br/>

* * *

## 📌 프로젝트 개요
#### 📅 기간
2024.02.08 ~ 2024.03.11 (4주)

- 1주차 : 프로젝트 기획 및 DB 구축 회의, 화면 설계(파트별 레이아웃 및 핵심 기능 설계)
- 2주차  : 파트별 DB 설계 및 구축, 개인별 화면 및 모델 개발 작업 진행
- 3주차 : 1차 기능테스트 및 작업현황 공유. 오류 수정
- 4주차 : 2차 기능테스트, 사이트 오픈 및 최종시연 프레젠테이션 준비
<br/>

#### 🖍 주제 및 목표
__[주제]__
  - 도서관 및 도서통합관리 웹
  - 선정 이유 : 
  	- 둘 이상의 사용자를 가정하고 각 환경에 맞는 통합 웹 환경을 구현할 것
    - 이용권한이 구분될 수 있는 케이스를 레퍼런스로 활용할 것
    - MVC패턴을 활용하여 온라인 도서관 대여 서비스 제공하는 웹사이트 제작
<br/>

__[목표]__
1. 1차 프로젝트 후의 피드백 반영 및 훈련기간 동안 학습한 내용의 적용		
2. 데이터베이스 구축 및 SQL문 연습과 뷰, 조인, 프로시저 등의 적극 활용
3. Front-end & Back-end의 다양한 기술스택을 활용한 웹 애플리케이션 구현
<br/>

#### 👥 팀 구성 및 사용기술
__[팀 구성]__
![team](https://github.com/mindyhere/Team-Projects/assets/147589193/c6a75515-71a3-433b-b6ab-56f93dbfb821 "개인별구현기능")
<br/>

__[사용기술 및 개발환경]__
- OS : Windows11
- Tools  :  Eclipse, SQL Developer, SVN
- Front-end  :  HTML/CSS, Javascript
- Back-end  :  JDK21, OracleDB 23.1.1
- Library  :  Lombok 1.18.30, MyBatis 3.5.15, Json, Jquery 3.7.1, JSTL, Ajax, Bootstrap 5.3, Sweetalert2, Chart.js 4.4.0, Apache Tomcat 10.1.19\
<br/>
<br/>
<br/>

* * *

## 🙋🏻‍♀ 주요 구현기능 설명
#### __🏫 홈화면__
![home1](https://github.com/mindyhere/Team-Projects/assets/147589193/d07826d7-e7e4-42fb-9488-2dbe8a12aa0d "home")

- 상단/하단메뉴바 : 아이콘 또는 버튼 클릭 시 링크이동
- 통합 검색창 배치
- 추천도서탭 배치
<br/>

#### __🎖 추천도서 탭__
![edit1](https://github.com/mindyhere/Team-Projects/assets/147589193/4ed58ced-dd68-45e6-987c-f9918b80bf90 "recommend")

- 대출이 많은 책 : 테이블 외부조인(대출테이블, 예약테이블)과 뷰를 활용해 대출 또는 예약이 많은 상위 5권을 페이지에 출력 
- 이달의 책 : 
  - 관리자로 로그인 시 추천도서 목록을 편집가능(EDIT 버튼 활성화 및 모달창)
  - 체크박스로 항목 전체 또는 선택 삭제
  - 도서명으로 추천도서를 검색하여 등록가능(5권이상 또는 중복등록 불가) → 저장프로시저(recmd_insert) 호출

```java
//관리자 추천도서 등록(insert) 프로시저
create or replace procedure recmd_insert(bid number, aid varchar2)   --도서고유번호, 관리자아이디
is
begin
 insert into recommend (idx, b_id, a_id)   --등록번호(pk), 도서고유번호, 관리자아이디
 values (recmd_seq.nextval, bid, aid);   --등록번호:시퀀스, 도서고유번호, 관리자아이디
end;
/

<!-- Mybatis, "recommend.xml" - 추천도서테이블에 insert할 때 호출 -->
<select id="recmd_insert" statementType="CALLABLE">
	{call recmd_insert(#{b_id}, #{a_id})}
</select>
```
<br/>

#### __🔎 도서검색__
![search101](https://github.com/mindyhere/Team-Projects/assets/147589193/731cc866-8697-4eaf-bc0b-f3076118632d "통합검색")
![search102](https://github.com/mindyhere/Team-Projects/assets/147589193/f1ee731a-bebb-4cc0-89bf-8d7b16d2f73b "상세검색")

- 키워드 통합검색 및 상세검색(제목/저자/발행처 기준) → 기본 도서고유정보와 대출/예약정보 통합조회
- 보기타입 전환 또는 페이지 이동 시 빠른 결과조회를 위해 ajax 적용
  - 목록타입, 앨범타입의 두가지 타입의 보기형식을 구현
  - 사이드메뉴로 검색기준 별 집계된 결과 수(링크이동) 배치
- 도서명 또는 아이콘(ⓘ) 클릭 시 도서상세정보 페이지로 이동
<br/>

#### __📖 상세정보 페이지인쇄 및 리뷰__
![print1](https://github.com/mindyhere/Team-Projects/assets/147589193/426a8e82-9efe-46e5-a638-8bff6f992924 "페이지인쇄")

- 페이지인쇄 : 자바스크립트 기본 함수를 활용하여 리뷰 제외한 도서정보 및 소장정보를 인쇄

![reviews1](https://github.com/mindyhere/Team-Projects/assets/147589193/3ce25308-e810-4ab2-a6e8-d40dfeaa7674 "한줄서평")

- 리뷰게시판 : ajax 및 커스텀 모달창을 적용하여 기능 구현. insert, delete 시 프로시저 활용
- 회원 : 글작성 및 본인이 작성한 게시글 삭제 권한(프로시저 활용) / 관리자 : 전체 게시글에 대한 삭제권한

```java
//도서리뷰 등록(insert) 프로시저
create or replace procedure review_insert(mid varchar2, bid number, content varchar2)	--회원아이디, 도서고유번호, 내용
is
begin
 insert into review (idx, m_no, b_id, contents)	--등록번호(pk), 작성자의 회원번호, 내용
 values (review_seq.nextval, (select M_NO from SL_MEMBER where M_ID=mid), bid, content);	--등록번호:시퀀스, 작성자의 회원번호(서브쿼리), 내용
end;
/

<!-- Mybatis, "review.xml" - 뷰테이블에 insert할 때 호출 -->
<select id="review_insert" statementType="CALLABLE">
	{call review_insert(#{m_id}, #{b_id}, #{contents})
</select>


//리뷰 삭제(delete) 프로시저
create or replace procedure review_delete(p_mid varchar2, p_idx number)	--회원아이디, 리뷰등록번호
is
begin
    delete from review
    where idx=p_idx	--리뷰등록번호
    and m_no=(select m_no from sl_member where m_id=p_mid); 	--작성자 회원번호
end; 
/  

<!-- Mybatis, "review.xml" - 회원(작성자)이 삭제할 경우에 호출 -->
<select id="user_delete" statementType="CALLABLE">
	{call review_delete(#{m_id}, #{idx})
</select>
```
<br/>

#### __🙋 도서대출 신청__
![checkout1](https://github.com/mindyhere/Team-Projects/assets/147589193/0fa4eede-7b5f-4c99-af39-926bcad769b7 "도서대출신청")

- 현재 비치중인 도서(대출가능도서)에 대해 사용자가 직접 대출신청하는 것으로 기능을 구현해 봄
- 대출불가한 경우 제외, 대출도서 테이블에 신청정보가 insert되고, 처리결과 성공/실패일 경우 alert로 사용자에게 알림
- 예약자가 신청한 도서가 대출할 수 있는 차례가 되었을 때, 나의서재에서 대출신청 가능하도록 기능구현. (모든 예약신청이 처리완료 될 때까지 해당도서는 대출불가 상태 유지)
- 대출불가인 도서의 경우, 도서상세페이지에서 "반납일"이 가장 빠른 날짜를 "반납예정일"로 표시함  
<br/>

#### __🖥 그 외 구현기능__
🔗 [sitemap](https://github.com/mindyhere/Team-Projects/blob/master/SamwolLibrary/gif/etc-sitemap.gif)
🔗 [alert & confirm](https://github.com/mindyhere/Team-Projects/blob/master/SamwolLibrary/gif/etc-customalert.gif)
🔗 [header & footer](https://github.com/mindyhere/Team-Projects/blob/master/SamwolLibrary/gif/etc-menu.gif)
<br/>
<br/>
<br/>

* * *
 
## 🎓 후기
#### __✏️ 프로젝트 후기__
- 비교적 단순했던 테이블관계나 SQL문장만을 활용했던 1차프로젝트와 달리, 다양한 테이블 관계 형성하고 프로시저나 뷰를 적극 활용할 수 있도록 노력했고 그 결과 많은 공부가 되었다.
- 프로젝트 규모가 커지면서 협업툴로 SVN을 활용하여 개발과정 중 상호간의 의사소통이나 버전관리 측면에서 더욱 효율적인 진행이 가능할 수 있었다.
- 팀 프로젝트를 통해 서로 부족한 부분을 채워 개인역량을 한층 발전시킬 수 있는 기회가 되었다.
<br/>

#### __🛠️ 개선점__ 
- 사용자의 편의성을 고려한 검색어 자동완성을 추가하여 기능 업그레이드
- 도서정보 오픈 API의 활용
- 협업툴로 Git 활용하기
- 온라인 중고서적 판매사이트나 도서관이용 모바일앱 개발 등으로 발전시키기
<br/>
<br/>
