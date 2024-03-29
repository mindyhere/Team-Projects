# 📱 1st project - Cafe management app
본 프로젝트는 국비지원 훈련과정 중 진행한 첫번째 팀프로젝트이며, 학습기록을 위해 업로드함.
<br/>
<br/>
<br/>
* * *
## 📌목차
[__1. 프로젝트 개요__](#-프로젝트-개요)
   - [프로젝트 설명](#-기간)
   - [진행과정](#-팀-구성-및-사용기술)
<br/>
  
[__2. 주요기능 설명__](#-주요기능-설명)
   - [메인 화면](#메인화면)
   - [매출 관리](#매출관리)
   - [재고 관리](#재고관리)
   - [메뉴 관리](#메뉴관리-) 🙋🏻‍♀
   - [회원 관리](#회원관리)
<br/>
    
[__3. 프로젝트 후기 및 발표자료__](#-후기)
<br/>
🔗 [프레젠테이션 자료 및 시연영상](https://docs.google.com/presentation/d/1bta7-0WddFHqetQJPtGQ5LRoqR3ZgtGICWrsuUFPvhQ/edit?usp=sharing)
<br/>
<br/>
* * *
## 📌 프로젝트 개요
#### 📅 기간
2023.12.18 ~ 2024.1.10 (3주)
<br/>


#### ✏️ 주제 및 목표
__[주제]__
  - 무인카페 키오스크 관리 시스템
  - 선정 이유 : 팀원 대부분 이번이 첫 프로젝트인 만큼 레퍼런스 활용 여부가 중요했기에 주위에서 흔히 접할 수 있는 무인 카페 시스템을 관리자 입장에서 만들어 보고자 선정함
<br/>


__[목표]__
1. 훈련 기간 동안 학습한 내용의 복습 및 적용		
2. 안드로이드 스튜디오에서 제공하는 다양한 기본 위젯 적용과 커스터마이징
3. 데이터베이스 구축 및 SQL문 연습
<br/>


#### 👥 팀 구성 및 사용기술
__[팀 구성]__  
![team](https://github.com/mindyhere/Team-Projects/assets/147589193/a1220534-44a1-4304-8ebb-c7b61e7250d2 "개인별구현기능")
<br/>


__[사용기술 및 개발환경]__
- OS : Window, Android
- Language : JAVA
- DB : SQLite
- Tools : Android Studio, SQLite expert personal, DB Browser for SQLite, Cmd
- Test device : Emulator (Pixel XL API 34)
<br/>


__[진행과정]__
- 1주차 : 프로젝트 기획 및 화면 설계, DB 구축, 파트별 레이아웃 및 핵심 기능 설계
- 2주차  : 파트별 DB 설계 및 구축, 프로그램 화면 및 세부 기능 구현, 1차 통합 및 프레젠테이션 자료 준비
- 3주차 : 기능 테스트 진행 및 2차 통합, 최종 점검 및 프로젝트 완성
<br/>
<br/>
<br/>

* * *

## 🕹 주요기능 설명
#### __메인화면__
- 관리자 로그인/로그아웃
- 로그인 정보 수정
- 메인메뉴에서 각 해당화면 이동
- AS 필요시 서비스 센터로 도움 요청(전화연결 기능)
<br/>


#### __매출관리__
- 주문번호/날짜로 주문내역 조회
- 일별, 월별 매출조회
- 월별 매출 엑셀파일로 다운로드
<br/>


#### __재고관리__
- 재고목록 조회 및 검색
- 물품 등록, 수정, 삭제 등 기본기능 구현
- 사용자 편의성 중심으로 구현
<br/>


#### __메뉴관리 🙋🏻‍♀__
- 상품(메뉴)조회 및 검색
  <br/>
![search1](https://github.com/mindyhere/Team-Projects/blob/master/CafeManagement/gif/search1.gif "search")
- 신규상품 등록 또는 상품분류 추가/삭제
  <br/>
![add1](https://github.com/mindyhere/Team-Projects/blob/master/CafeManagement/gif/add1.gif "add product") &nbsp;&nbsp;
![edit-category1](https://github.com/mindyhere/Team-Projects/blob/master/CafeManagement/gif/edit-category1.gif "edit-category")
- 상품 정보수정 및 삭제
  <br/>
![edit1](https://github.com/mindyhere/Team-Projects/blob/master/CafeManagement/gif/edit1.gif "edit product")
- 사용자의 유동적 관리가 가능하고, 프로그램 사용에 직관적이고 간결하게 구성
<br/>


#### __회원관리__
- 회원 검색 및 정렬방식에 따른 회원 조회
- 사용자가 직접 입력한 회원정보 수정 또는 회원정보 삭제
- 관리자계정 자동로그인
<br/>
<br/>
<br/>

* * *
 
## 🎓 후기
#### __✏️ 프로젝트 후기__
- 웹 & 앱에서 각 이용되는 데이터베이스를 사용해 봄으로써 데이터베이스의 종류에 대해 알게 됨
- 기본 제공 위젯이나 어댑터 등을 각자 다양한 방식로 활용해 보며 많은 공부가 되었음
- 파트 분담 후 통합하는 과정에서 서로 간에 충분한 논의나 주석 활용을 통해 더 효율적으로 진행하지 못한 점이 아쉬움으로 남음
<br/>


#### __✏️ 개선점__ 
- 전체 프로젝트 structure 및 각 액티비티에 공통으로 사용되는 메소드를 호출하는 방식 등을 고려한 재구성
- 더 간결하고 깔끔한 코드로 구성하여 가독성 향상 
- 향후 훈련 과정을 통해 학습하게 될 jsp, Spring 등을 활용하여 웹과 연동할 수 있도록 추가 확장
- 관리자 계정 등록 기능 및 사용자 화면 구성하여 연결
<br/>
