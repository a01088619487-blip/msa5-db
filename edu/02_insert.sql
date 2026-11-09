-- INSERT문
-- DML 중 하나로 신규 데이터를 저장하기위해 사용하는 쿼리
-- INSER INTO 테이블명[(컴럼1,컬럼2...)]    컴럼쪽은 생략이 가능하지만 거진 생략안함.
-- VELIES (값1,값2...);   값1->컬럼1 로 가고 값2->컬럼2에감 그래서 지정해주는것이 가장 좋다.
INSERT INTO employees(
--	emp_id  생략가능
	`name`
	, birth
	, gender
	, hire_at
	
--	, fire_at	생략가능
--	, sup_id	생략가능
--	, created_at	생략가능
--	, updated_at	생략가능
--	, deleted_at	생략가능
)
VALUES (
	'김다운'
	, '2000-01-01'
	, 'F'
	, NOW()   
-- ★★현재 시간을 가져오는 함수★★★
	, DEFAULT -- 디폴트를 지정도 가능하나, 일반적으로는 컬럼 자체 생략 이 가능하다
	-- 디폴트가 흠...뭔디=ㅅ=...
);

-- 복수의 레코드를 삽입하고 싶을 경우
INSERT INTO employees(`name`	, birth	, gender	, hire_at)
VALUES ('김다운', '2000-01-01', 'F', NOW()),
('김갑순', '2005-04-05', 'F', NOW()),
('홍길동', '1990-07-30', 'M', NOW());

-- SELECT INSERT
-- 조회된 결과를 가지고 INSERT 를 실행
-- PK기준으로 가져와도 되지만.. 앰플로이즈앤 잇지만 타이틀앰플로이즈앤 없는경우가 잇다 
-- 그래서 이건 고급스킬이라 추후에 배우기로함.
INSERT INTO title_emps(
	emp_id
	, title_code
	, start_at
	, end_at
	, created_at
	, updated_at
	, deleted_at
)
SELECT
	emp_id, 'T001' , NOW(), NULL,NOW(),NOW(), NULL
	-- 신입사원이라 title_code 은 t001로 지정, 다른건 지정해여험~
FROM employees
WHERE
	emp_id > 100000
;
	
