# 📁 Team Projects (2023 ~ 2024)

국비지원 교육훈련과정 (쌍용강북교육센터, 2023.11 ~ 2024.06) 중 진행한 팀 프로젝트 모음입니다.

> 각 프로젝트 폴더의 README에서 상세 구현 내용, ERD, 코드 스니펫을 확인할 수 있습니다.

<br/>

---

## 🗂 프로젝트 목록

| # | 프로젝트 | 기간 | 주요 기술 |
|---|----------|------|-----------|
| 4 | [🏨 SYBNB — 숙박 예약 웹서비스](#-sybnb-숙박-예약-웹서비스) | 2024.04 ~ 2024.06 | Java, Spring, React, MariaDB, AWS |
| 3 | [📚 syLibrary2 — 도서관 웹 v2](#-sylibrary2-도서관-웹-v2) | 2024.04 | Java, Spring Boot, OracleDB |
| 2 | [📖 삼월도서관 — 도서관 이용 웹사이트](#-삼월도서관-도서관-이용-웹사이트) | 2024.02 ~ 2024.03 | Java, JSP/Servlet, OracleDB |
| 1 | [☕ CafeManagement — 카페 운영 관리 앱](#-cafemanagement-카페-운영-관리-앱) | 2023.12 ~ 2024.01 | Java, SQLite, Android Studio |

<br/>

---

## 🏨 SYBNB 숙박 예약 웹서비스

최종 프로젝트

**기간** | 2024.04.24 ~ 2024.06.05 (약 6주)  
**스택** | Java(JDK21), Spring Framework, MyBatis, React, JavaScript, MariaDB, AWS EC2  
**협업** | Git, GitHub, Sourcetree  

**담당 구현 기능**
- 호스트 예약관리 : 예약 확정/변경 처리, 바우처 이메일 발송
- 예약 프로세스 : 프로시저 및 트리거 활용 (예약확정 → 체크인 → 포인트 지급)
- 월간 예약 스케줄러 (react-calendar)
- 호스트 계정관리 : 회원가입, 로그인, 정보수정, 탈퇴 (Spring Security 적용)
- 전월 대비 매출 현황 그래프 (chart.js)
- 로그인 만료 타임아웃 알람 (쿠키 유효기간 기반)

📂 [상세 보기](./sybnb(final%20project)) &nbsp;|&nbsp; 🔗 [발표자료](https://docs.google.com/presentation/d/17xhSXil2K-h7-_tIEPv6zsKwHZvXYaMbxjTMpMjHYV8/edit?usp=sharing) &nbsp;|&nbsp;

<br/>

---

## 📚 syLibrary2 도서관 웹 v2

Spring Boot 프레임워크 기반 리팩토링

**기간** | 2024.04.01 ~ 2024.04.19 (약 3주)  
**스택** | Java(JDK21), Spring Boot, MyBatis, JavaScript, jQuery, Ajax, OracleDB  
**협업** | Git, GitHub  

**담당 구현 기능** *(2차 프로젝트 JSP → Spring Boot 리팩토링 + 기능 추가)*
- 검색어 자동완성 기능 추가 (jQuery autocomplete, Ajax)
- 도서 검색 결과 처리 로직 개선 (switch문으로 간소화)
- 희망도서 신청 기능 추가 (알라딘 도서검색 Open API 연동)
- 도서 대출 신청 프로시저 및 회원 등급별 대출 기준 반영

📂 [상세 보기](./syLibrary2(3rd%20project)) &nbsp;|&nbsp; 🔗 [발표자료](https://docs.google.com/presentation/d/1EiQ5zPQsIVHS_wUwzLL1DPvhh02L0ezI-vCAWCXQWTE/edit?usp=sharing)

<br/>

---

## 📖 삼월도서관 도서관 이용 웹사이트

MVC 패턴 실습

**기간** | 2024.02.08 ~ 2024.03.11 (약 4주)  
**스택** | Java(JDK21), JSP/Servlet, MyBatis, JavaScript, jQuery, Ajax, OracleDB  
**협업** | SVN  

**담당 구현 기능**
- 도서 통합검색 및 상세검색 (제목/저자/발행처), Ajax 페이징 처리
- 도서 대출 신청 (프로시저 활용, 대출 가능 여부 및 중복 신청 검증)
- 도서 상세정보 페이지 및 리뷰 게시판 (프로시저 활용, 권한별 삭제)
- 메인 홈화면 및 추천도서 탭 (대출이 많은 책, 이달의 책)
- 팀장 및 발표 담당

📂 [상세 보기](./SamwolLibrary) &nbsp;|&nbsp; 🔗 [발표자료](https://docs.google.com/presentation/d/19Hi8HgZE-Zn88lhW7pmRSJ1mOBWTmTxJ34NunvYbvU4/edit?usp=sharing)

<br/>

---

## ☕ CafeManagement 카페 운영 관리 앱

**기간** | 2023.12.18 ~ 2024.01.10 (약 3주)  
**스택** | Java(JDK21), SQLite, Android Studio  

**담당 구현 기능**
- 카페 메뉴 조회 및 검색 (텍스트 자동완성 적용)
- 신규 상품 등록 및 상품 분류 추가/삭제
- 상품 정보 수정 및 삭제

📂 [상세 보기](./CafeManagement) &nbsp;|&nbsp; 🔗 [발표자료](https://docs.google.com/presentation/d/1bta7-0WddFHqetQJPtGQ5LRoqR3ZgtGICWrsuUFPvhQ/edit?usp=sharing)
