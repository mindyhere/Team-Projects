# 🏨 SYBNB 숙박 예약 웹서비스
본 프로젝트는 국비지원 훈련과정 중 진행한 파이 팀 프로젝트입니다.
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
   - [호스트 예약관리 페이지](#-호스트-예약관리-페이지)
   - [호스트 계정 페이지](#-호스트-계정-페이지)
   - [후기 및 평점 기능](#-후기-및-평점-기능)
   - [로그인 타임아웃 알람](#-로그인-타임아웃-알람)
<br/>
    
[__3. 프로젝트 후기 및 발표자료__](#-후기)
<br/>
🔗 [프레젠테이션 자료](https://docs.google.com/presentation/d/17xhSXil2K-h7-_tIEPv6zsKwHZvXYaMbxjTMpMjHYV8/edit?usp=sharing)  <br/>
🔗 [AWS EC2 배포 페이지](http://3.35.97.107) 
<br/>
<br/>
<br/>

* * *

## 📌 프로젝트 개요
#### 📅 기간
2024.04.24 ~ 2024.06.05 (약 5주)

- 1주차 : 주제선정 및 프로젝트 기획회의. DB설계. 개발환경 세팅
- 2~3주차 : 개인별 집중 개발 진행 후 1차 통합테스트 진행
- 4주차 : 세부기능/추가기능 등 피드백 후 수정 작업 진행
- 5주차 : 2차 통합테스트 및 오류 수정
- 6주차 : 발표자료 및 프레젠테이션 준비. 6/11 최종시연
![wbs](https://github.com/mindyhere/final-project/assets/147589193/b84a3a08-e371-4b95-b87d-78565db5afc1 "WBS sheet")

<br/>

#### 🖍 주제 및 목표
__[주제]__ : 숙박 예약 웹서비스

__[목표]__
1. Spring MVC 패턴에 기반하여 사용자 간의 상호작용이 이루어지는 웹서비스 구현
2. 결제API, 공유하기, 달력, 주소검색 등 다양한 API를 활용하고 훈련기간 동안 학습한 기술스택을 총체적으로 보여줄 수 있는 서비스 구현
3. DB구축 및 SQL 연습
4. 직관적인 UI/UX 구성
<br/>

#### 👥 팀 구성 및 사용기술
__[팀 구성]__
![team1](https://github.com/mindyhere/final-project/assets/147589193/822e1218-4ab4-4b97-bb46-da5518d49584 "개인별구현기능")

<br/>

__[사용기술 및 개발환경]__
- OS : Windows11
- Tools  :  Spring Tool Suite 4, Heidi SQL 12.6, Git, GitHub, Sourcetree, Draw.io
- Front-end  :  HTML/CSS, React, Javascript
- Back-end  :  Java(JDK21),Spring Framework, MariaDB 11.3
- Library  :  Lombok 1.18.30, MyBatis 3.5.15, Bootstrap 5.3, Sweetalert2, Chart.js 4.4.0, etc.
<br/>
<br/>
<br/>

* * *

## 🙋🏻‍♀ 주요 구현기능 설명
#### __📇 호스트 예약관리 페이지__
![ex2](https://github.com/mindyhere/Team-Projects/assets/147589193/0f112fcf-1537-4844-a871-73fd7a3067fb)

#### __[1] 예약현황__
1)월간 스케쥴러 : react-calendar 라이브러리 활용 → 달력형태로 구현
- 예약내역 확인 및 상태 변경 가능
- 체크인(●)/체크아웃(▲) 스케쥴 표시 및 확정/완료 상태인 예약에 하이라이트 처리
  
2)예약 변경 요청
- 변경접수된 예약목록을 slider로 표시(해당 예약은 달력/예약목록에서 제외)
  
  ![ex5](https://github.com/mindyhere/Team-Projects/assets/147589193/72b7a1e3-7414-4402-a8c0-35d216f9c79c)
<br/>

- 변경 가능한 경우, 승인처리 : 프로시저 호출(“확정”상태로 업데이트, 수정관리테이블에서 레코드 삭제) → 변경된 내역으로 바우처 이메일 발송
  ![ex6](https://github.com/mindyhere/Team-Projects/assets/147589193/bd76aa64-01e3-4f7a-b847-be58de424710)
<br/>

- 변경 불가한 경우, alert 및 거부처리 : 수정관리 테이블의 처리상태 업데이트 → 트리거 실행(기존내역으로 예약 재확정) 및 바우처 재발송
  <details>
  	<summary>코드보기</summary>
    
    ```MariaDB
  // 1. 예약변경 접수된 예약 건 → 승인 버튼 클릭 시 "승인처리(예약확정)" 프로시저 실행 
    CREATE PROCEDURE p_order_modify(
    # in/out 파라미터 선언
  IN oidx INT, IN ckin VARCHAR(10), IN ckout VARCHAR(10), IN adult INT, IN child INT, IN baby INT, IN hidx INT,
  OUT level INT, OUT result INT	)
  BEGIN	
    DECLARE exit handler for SQLEXCEPTION    # SQL에러라면 ROLLBACK 처리
      BEGIN
        ROLLBACK;
  	    SELECT h_level INTO level FROM host WHERE h_idx=hidx;        
  	    SET result = 0;  
      END;
  
    UPDATE orders     # 예약 테이블 업데이트
    SET 	o_ckin = STR_TO_DATE(ckin, '%Y-%m-%d'),
  	      o_ckout = STR_TO_DATE(ckout, '%Y-%m-%d'),
  	      o_adult = adult,
  	      o_child = child,
  	      o_baby = baby,
  	      o_state = 3 	# oidx 의 상태 ‘확정’으로 업데이트
    WHERE o_idx = oidx;
         
    DELETE FROM reserv_update WHERE ru_idx = oidx;     # 예약변경내역 테이블에서 레코드 삭제
    COMMIT;
          
    SET result=1;      # 현재 h_level 레벨 조회 후 out파라미터에 저장
    SELECT h_level INTO level FROM host WHERE h_idx = hidx;
  
  END      # 프로시저 종료
  
  
  // 예약 '변경불가' 처리(Spring, Mybatis UPDATE문 실행) → 기존예약 자동확정 트리거 실행
  CREATE TRIGGER t_update_ostate
  	AFTER UPDATE ON reserv_update    # reserv_update 의 변경 감지
  	FOR EACH row
  BEGIN  	# 변경요청이 거부(ru_state = 0 으로 UPDATE)되었을 때
  	IF NEW.ru_state != OLD.ru_state
  	THEN    UPDATE orders
  		      SET o_state = 3		
  		      WHERE o_idx = OLD.ru_idx;    # ORDERS 의 기존예약을 찾아 예약상태를 확정으로 변경
  	END IF;	
  END;
  ```
  
  </details> 

#### __[2] 예약목록__
- 숙박업소 별 예약목록 게시판
- “상태” 클릭 시 예약상태 별로 정렬 → 대기예약 건 신속히 조회 가능
- 예약대기 → 예약확정 처리 : 고객 이메일로 바우처 발송
- 예약확정 → 체크완료 처리 : 체크인 당일, “체크인완료” 버튼 활성화 → 프로시저 호출(DB상태 업데이트/호스트 레벨 업데이트) → 트리거 실행(최종 결제금액 및 회원레벨에 따른 포인트 지급처리)

  <details>
  	<summary>코드보기</summary>
    
    ```MariaDB
  // 1. 체크인완료 처리 및 호스트 레벨 업데이트 프로시저
    CREATE PROCEDURE p_order_confirm(
    # in/out 파라미터 선언
  IN opt INT, IN oidx INT, IN hidx INT, OUT level INT, OUT result INT)
  BEGIN	
    ( # … 중략. 변수선언 및 SQL에러라면 ROLLBACK 처리)
  
  	SELECT COUNT(*) INTO complete 	# 완료예약 건수
      FROM v_host_order
      WHERE ho_idx IN (select ho_idx from hotel where ho_h_idx=hidx)
          AND o_state=3; 
  		
  	SELECT COUNT(*) INTO rpcount		# 답글 개수
      FROM v_host_reply
      WHERE ho_idx IN (select ho_idx from hotel where ho_h_idx=hidx);
  
      SELECT COUNT(*) INTO cancel 		# 최근한달 예약 취소건수
      FROM v_host_order
      WHERE ho_idx IN (select ho_idx from hotel where ho_h_idx=hidx) 
          AND o_state=2
          AND o_orderdate BETWEEN DATE_ADD(NOW(), INTERVAL -1 MONTH ) AND NOW(); 	
      START TRANSACTION;
  
    # o_idx 상태 업데이트(opt=1 예약확정일 경우, opt=0 예약취소일 경우)
      UPDATE orders
      SET o_state =
        CASE
          WHEN opt = 1 THEN 4	# 체크인완료
          ELSE 2 END	# 예약취소
      WHERE o_idx = oidx; 	# o_idx 상태 업데이트
  
    # 호스트 레벨 업데이트
      IF ((complete > 10) AND (rpcount > 10) AND (cancel < 3))
      THEN
          UPDATE host SET h_level = 9 WHERE h_idx=hidx;
      ELSE
          UPDATE host SET h_level = 8 WHERE h_idx=hidx;
      END IF;
      COMMIT;
  	
      SET result=1; 
      SELECT h_level INTO level FROM host WHERE h_idx = hidx;  # 현재 레벨 조회 후 out파라미터에 저장 
  	
  END;		# 프로시저 종료
  
  // 체크인완료 UPDATE → 결제 포인트 지급 트리거 실행
  CREATE TRIGGER t_update_point
  	AFTER UPDATE ON orders
  	FOR EACH row
  BEGIN 
  	DECLARE gpoint INT;		# 현재 보유중인 포인트
  	DECLARE price INT; 		# 결제금액
  	DECLARE benefit DECIMAL;	# 포인트 지급 비율
  	
  	SELECT o_finalprice INTO price FROM orders
  	WHERE o_idx = OLD.o_idx;
  	
  	SELECT l_benefit INTO benefit FROM level
  	WHERE l_level = (SELECT g_level FROM guest WHERE g_idx = OLD.o_gidx);
  	
  	SELECT g_point INTO gpoint FROM guest
  	WHERE g_idx = OLD.o_gidx;
  	
  	IF NEW.o_state = 4
  	THEN 
  		UPDATE guest
  		SET g_point = (gpoint+price*benefit*0.01)
  		WHERE g_idx = OLD.o_gidx;
  	END IF;	
  END; 
  
  ```
  
  </details> 

<br/>

#### __🪪 호스트 계정 페이지__
![ex7](https://github.com/mindyhere/Team-Projects/assets/147589193/dfc8d10d-c240-42d9-8887-a80be396ecf2)

#### __[1] 호스트 회원정보 : 회원정보 및 가입상태 조회__
- 호스트 승인신청 기능 : 필수 등록 첨부파일이 DB에 저장되어 있을 경우, 신청버튼 활성화 → 승인신청이 정상처리된 경우 업데이트 된 가입상태를 표시
- 기본 회원레벨 “8” → “9”인 회원은 “SUPER” 마크 표시

#### __[2] 서비스 이용현황__
- 전월대비 매출현황 그래프 : chart.js 라이브러리 활용
- 등록된 호텔 별 평점, 예약, 후기 현황 요약

  <details>
    
  <summary>코드보기</summary>
   
  ```Spring
  // 지난달 매출
    <select id="lastMonth" resultType="java.util.Map">
      select this.*
      from (
      	select date_format(o_ckin, '%Y-%m') AS month, sum(ifnull(o_finalprice*0.8,0))/1000000 sales, ho.ho_name, ho.ho_idx
      	from v_host_order v right join hotel ho
      	on 
      		o_state=4
      		and o_ckin between date_format(now()-interval 1 month, '%Y-%m-01') and last_day(now()-interval 1 month)
      		and v.ho_idx=ho.ho_idx
      	group by month, ho_name
      	order by ho.ho_idx
      	) this
      where ho_idx in (select ho_idx from hotel where ho_h_idx = #{h_idx})
    </select>
  
  // 이번달 매출
    <select id="thisMonth" resultType="java.util.Map">
      select this.*
      from (
      	select date_format(o_ckin, '%Y-%m') AS month, sum(ifnull(o_finalprice*0.8,0))/1000000 sales, ho.ho_name, ho.ho_idx
      	from v_host_order v right join hotel ho
      	on 
      		o_state=4
      		and o_ckin between date_format(now(), '%Y-%m-01') and last_day(now())
      		and v.ho_idx=ho.ho_idx
      	group by month, ho_name
      	order by ho.ho_idx
      	) this
      where ho_idx in (select ho_idx from hotel where ho_h_idx = #{h_idx})
    </select>
  ```
     
  </details>

#### __[3] 후기 관리 게시판__
- 게스트가 등록한 리뷰 조회 및 키워드 검색
- 각 리뷰에 대한 호스트의 답글 등록, 수정, 삭제 : 팝업창으로 연결
  
<br/>

#### __🌟 후기 및 평점 기능__

![image](https://github.com/mindyhere/Team-Projects/assets/147589193/ab0f505b-ad08-45c3-9b08-a45bc4a6e325)

#### __[1] 게스트, 후기작성 및 수정/삭제 관리__
- 부모창에서 버튼 클릭 시 리뷰/평점 데이터 local storage에 저장 → 작성/수정 팝업창으로 연결
- 평점기능 컴포넌트 구현

  <details>
    
  <summary>코드보기</summary>
   
  ```React
  // StarRate.js
  function StarRate({ rate, handleStarRating }) {
    const [star, setStar] = useState(rate);
    return (
      <span>
        {[...Array(star)].map((a, i) => (
          <StarFill
            size={20}
            color="#FCD53F"
            style={{ margin: "0 1px 2% 0" }}
            key={i}
            onClick={() => {
              setStar(i + 1);
              handleStarRating(i + 1);
            }}
          />
        ))}
        {[...Array(5 - star)].map((a, i) => (
          <Star
            size={20}
            color="grey"
            style={{ margin: "0 1px 2% 0" }}
            key={i}
            onClick={() => {
              setStar(star + i + 1);
              handleStarRating(star + i + 1);
            }}
          />
        ))}
        <input type="hidden" value={star} />
      </span>
    );
  }
  ```
     
  </details>

- 후기 수정 시, 기존에 작성된 내용/평점 표시 → 수정사항 입력 후 “수정”버튼 클릭 시 DB업데이트 및 팝업창 close
- “삭제” 버튼 클릭 시, 비밀번호 확인 후 해당 후기의 게시상태 “삭제(1)” 업데이트 → 답글 게시상태도 삭제상태 처리(트리거)

  <details>
    
  <summary>코드보기</summary>
   
  ```MariaDB
  # 게스트 : 자신이 작성한 리뷰 삭제 : Mybaits, UPDATE 쿼리 실행
    <update id="updateDeleted">
		update review set rv_deleted=1 where rv_idx=#{rv_idx}
	  </update>
  
  # 트리거 실행 : 호스트의 답글 “삭제상태”로 변경
  CREATE TRIGGER t_update_rpdeleted
    AFTER UPDATE ON review		# review 의 변경 감지
    FOR EACH row
  BEGIN  	# 게스트가 리뷰 삭제 → 해당 레코드를 ”삭제상태”로 업데이트
    IF NEW.rv_deleted != OLD.rv_deleted
      THEN    # 해당 리뷰에 호스트가 작성한 답글(reply)를 찾아 업데이트
        UPDATE reply
        SET rp_deleted = 1	# “삭제상태”로 업데이트
        WHERE rp_rv_idx = OLD.rv_idx;		
	  END if;	
  END;

  ```
     
  </details>

#### __[2] 호텔 상세 페이지 내 후기 및 평점__  
- 평균평점 및 최신등록 순으로 최대 6개의 후기 표시 : 전체 6개 이상일 경우, “모두보기” 버튼 활성화
- 작성내용이 20자 이상 → “더보기” 활성화, 클릭 시 모달 내 해당 리뷰로 포커스 이동 
- 키워드 검색 및 조회(정렬옵션 : 최신등록, 높은평점, 낮은평점 순)
- 호스트 답글 : 펼치기/접기기능 구현
  
#### __⏰ 로그인 타임아웃 알람__ 
![timeout1](https://github.com/mindyhere/Team-Projects/assets/147589193/f1ae616a-016e-4472-bfeb-082f38147897)

- 쿠키 타임아웃 및 로그아웃 alert 
- 게스트/호스트/관리자 로그인 시 쿠키 유효기간 24h → 만료 시 타임아웃 알람 및 계정 로그아웃
  
  <details>
  	<summary>코드보기</summary>
  	
        ```React
        // Header.js
        const timeoutAlert = (type) => {
          timerRef.current = setTimeout(() => {
            Swal.fire({
              icon: "warning",
              title: "Check",
              html: "세션이 만료되었습니다.</br>메인 화면으로 이동합니다.",
              showConfirmButton: false,
              timer: 3000,
            }).then(() => {
              window.location.href = "/";
            });
            removeCookies(type);
          }, 1000 * 60 * 60 * 24);
        };
        
        useEffect(() => {
        return () => clearTimeout(timerRef.current);
        }, []);
        
        ```
  
  </details>
 
<br/>
<br/>
<br/>

* * *
  
## 🎓 후기
#### __💡 후기__
- 안드로이드를 활용한 숙박예약어플, 관리자-호스트 매출/정산 기능 등 기획단계에서 더 많은 아이디어가 나왔었는데 여건 상 시도하거나 최종 구현하지 못한 부분들이 아쉬움으로 남는다.
- 프로젝트 기획과정에서 다양한 테이블 관계형성과 프로시저, 새로운 프론트엔드(React)를 활용할 수 있도록 노력했고 그 결과 많은 공부가 되었다. 
- 팀 프로젝트를 통해 많이 배우고 부족한 부분을 채워 성장할 수 있는 계기가 되었다. 
<br/>

