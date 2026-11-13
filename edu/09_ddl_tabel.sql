CREATE DATABASE test;
USE test;  -- tset 만들엇윰
	

-- ------------------
-- 개념적 설계
-- 테이블과 필요한 속성들이 무얼일까? ->컬럼
-- 어떤거 만들지 적음.
-- ------------------

-- ------------------
-- 테이블 생성
-- ------------------
-- table 작업

-- 유저 테이블
-- 개념점 모델링:  pk,이메일,패스워드PW, 이름, 생년월일, 전화번호,  성별,  주소,프로필,  id
-- 가입일자,탈퇴일,작성일, 수정일 , 삭제일...
-- ->provider ,팔로워,팔로잉에선 지금 연동된계정에 다른계정이 없으므로 더미데이터로 덮을꺼다

CREATE TABLE users(     -- create 에서 스키마 tavle에서 uesers 를 이름으로 정할것다.
	id 				BIGINT 	PRIMARY KEY AUTO_INCREMENT -- 물리명 데이터타입
	,email 			VARCHAR(100) 		NOT NULL 	UNIQUE  -- 물리명 데이터타입 제약조건 UNIQUE(여기서 지정해도됨)
	-- UNIQUE 잘관리는 해주는데 우리팀에서 사용하는 유니크나 FK가 규칙이 정해져잇으다면..음음
	,`password`		VARCHAR(255) 		NOT NULL -- password 키패드가 있어서 `` 넣음
	,user_name 		VARCHAR(30) 		NOT NULL
	,birth 			DATE 					NOT NULL 
	,phone 			CHAR(13) 			NOT NULL 	COMMENT '''010-0000-0000'',하이픈 포함 13자리' 
	-- comment  ''문자열안에 ''''홀따움표넣어줌 
	-- 한셋트만 넣으면 ''010-0000-1111'' 로만 하면 '' <-여기서 끝나버리기 때문에 
	--  '\'010-0000-0000\',하이픈 포함 13자리' 이런식으로도 가능함 -> 제일 많이사용
	-- 우리가 설계할때 '' 이걸 사용했기때문에 '\ 백슬레이스는 내뒤에잇는 문자열하나만 
	-- 인식 시킨다.. 웨? 이건 물어봐야할듯.. 백슬레이스는 엔터위에잇는달러
	,gender 				CHAR(1) 			NOT NULL 	COMMENT '\'M\',\'F\''
	,addr_number 		CHAR(5)
	,addr1 				VARCHAR(50)
	,addr2 				VARCHAR(50)
	,`profile` 			VARCHAR(100)
	,hired_at 			DATE 				NOT NULL 	DEFAULT (CURRENT_DATE())
	-- 뒤에 사용할게 참..
	-- now()할경우 ex)2026-11-12 11:41: 00 초까지 다들어가짐.그래서 디폴트 값으로now금지
	-- (CURRENT_DATE()) 여기에 소괄호 한번 더 넣어야하는이유?
	--  ->일반 함수는 키워드로 만들어진게 아니라서 연산결과가 들어간거는 ()를 넣어야한다
	
	,withdrawn_at 		DATE 								DEFAULT NULL
	,created_at 		DATETIME 		NOT NULL 	DEFAULT CURRENT_TIMESTAMP()
	,updated_at 		DATETIME			NOT NULL 	DEFAULT CURRENT_TIMESTAMP()
	,deleted_at 		DATETIME  						DEFAULT NULL 
	,CONSTRAINT uk_uers_email UNIQUE (email)
	--  CONSTRAINT 제약조건 (키워드로 이름을 별도로 지정)
	--	UNIQUE (email) -- 유니크 이름 지정 ()소괄호 빼먹으면 안됨!
	-- 이메일이라는 컬럼에 유니크라는걸 추가하고 uk_uers_email 라는 이름을 지정한다.
	
);



-- 게시글 테이블
-- pk,제목 , 본문,이미지 ,작성일, 작성자,게시글 삭제일,작성일, 수정일 , 삭제일
-- ->수정여부 -> 어떤 유저가 어떤테이블을 어떤값에서 어떤값으로 바꿧다 몇월 몇일에!!
-- [게시글에 포함된거라 이건 XX 댓글, 대댓글XX  테이블 별도 ]
-- 이미지는 여러개 넣고싶으면 이미지 테이블로 분류로  빠진다 
	-- (1개만 넣는거면 게시글에도 가능함 그렇지만 대체론 1개만 .)
-- 좋아요,공유,븍마크도 다른 테이블
SHOW TABLES;

CREATE TABLE posts(
	id 					BIGINT 			PRIMARY KEY AUTO_INCREMENT 
	,user_id 			BIGINT 			NOT NULL 
	-- ,user_id 		BIGINT 			NOT NULL  FOREIGN KEY 로해도되는데 어려워서 잘안씀
	,title 				VARCHAR(100) 	NOT NULL 
	,content				VARCHAR(500) 
	,image 				VARCHAR(100) 	NOT NULL
	,deactivated_at	DATE 								DEFAULT NULL 
	,created_at 		DATETIME 		NOT NULL 	DEFAULT CURRENT_TIMESTAMP()
	,updated_at 		DATETIME 		NOT NULL 	DEFAULT CURRENT_TIMESTAMP()
	,deleted_at 		DATETIME 						DEFAULT NULL
	
	,CONSTRAINT fk_posts_user_id FOREIGN KEY (user_id) REFERENCES users(id)
	--  CONSTRAINT 키워드로 이름을 별도로 지정
	--  REFERENCES users(id)  REFERENCES-어디문 참조할랭?
);


 -- 테이블 지우기
DROP TABLE IF EXISTS posts;   -- post가 users를 참조하니까 먼저 지워야 함.
DROP TABLE IF EXISTS users;
-- -----------
-- 테이블 수정
-- -----------

-- 컬럼 추가
-- ALTER TABLE [테이블명]  
-- ADD COLUMN [컬러명] [타입] [제약조건]; 
ALTER TABLE users
ADD COLUMN birth_month CHAR(2) NOT NULL COMMENT '\'MM\'양식';
-- CHAR(2) 이 데이터타입을 바꾸면 에러가 난다. 
-- ex) intger로 바꾸면 에러가남 왜냐 문자열과 in는 다른값이기때문에
-- 반드시 기존타입은 냅두고 인서트 작업 새로운 컬럼을 다시 바꾸고 필요없는 걸 드랍하는걸로??
-- 길이를 바꿀때 줄일때가 문제가됨 늘리는건 괜찮다 100-> 500으로 바꿔도 괜찮지만
-- 100 -> 90으로 줄이면 에러가 난다.
-- 컬러명을 바꿀때 기존걸 지우고 새로 추가해야한다.


-- 컬럼 수정 :새로 정의하고싶은것 까지 적어줘야함.
ALTER TABLE users
MODIFY COLUMN birth_month CHAR(2) COMMENT '\'MM\'양식';


-- 컬럼 삭제
ALTER TABLE users
DROP COLUMN birth_month;




-- 제약 조건 (Constraint) 추가
-- posts 테이블에 fk 제약조건 추가
ALTER TABLE posts
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

SHOW CREATE TABLE posts; -- FK가 걸려 있는지 확인하기

-- 제약 조건 (Constraint)제거
ALTER TABLE posts 
DROP CONSTRAINT fk_posts_user_id;



-- -----------------------
-- AUTO_INCREMENT 값 변경
-- -----------------------
ALTER TABLE users AUTO_INCREMENT = 1 ;
-- '1' 씩 증가 할수있게
-- 확인할만한 곳이 없넹


-- ----------------------
-- TRUNCATE 문 : 테이블의 모든 데이터를 깨끗하게 제거 하는 문법  복구XX
-- ----------------------
TRUNCATE TABLE usersusers; 


-- ---------------
-- 테이블 삭제
-- --------------
DROP TABLE posts ,users;  -- ,를 붙이면 같이 지워짐 



