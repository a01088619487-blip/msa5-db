-- SELECT 문
-- DML 중 하나로, 저장되어 있는 데이터를
-- 조회하기 위해 사용하는 쿼리
-- SELECT 절: 조회한 데이터 중 특정 컬럼만 출력
SELECT
	emp_id
	,`name` -- 백틱 (`)으로 감싸면, 컬럼으로써 인식 시킨다.
	,gender 
FROM employees -- 테이블 지정
;

-- Asterrisk(*) 별표:전체 컬럼 조회
SELECT 
	* 
FROM employees
;

-- WHERE 절 : 툭정 컬럼의 값이 조건에 맞는 데이터만 조회
-- 사번이 10009인 사원의 모든 정보를 조회해 주세요.
SELECT 
	* 
FROM employees
WHERE
	emp_id = 10009
;

-- 사원명이 "박보람"인 사원의 정보를 조회해 주세요.
SELECT
	*
FROM employees emp
WHERE 
	`name` = "박보람"
;

-- 생일이 2000-01-01 이후인 사원 모두 찾아주세요.
SELECT
	*
FROM employees
WHERE
	birth >= '2000-01-01'
;

-- 퇴사하지 않은 사원 정보 다 주세요.
SELECT
	*
FROM employees
WHERE
	fire_at IS NULL
;

-- 퇴사하지 않은 사원 정보 다 주세요.
SELECT
	*
FROM employees
WHERE
	fire_at IS NOT NULL
;

