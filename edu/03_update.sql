-- UPDATE문  [수정문]
-- DML 중 하나로 저장되어 있는 기존 데이터를
-- 수정하기 위해 사용하는 쿼리
-- UPDATE 테이블명
-- SET
-- 	컬럼 1 = 값1
-- [, 컬럼 2= 값2...] 이렇게 반복
-- WHERE 절  생략은 가능함..
-- 100005 사원의 이름을 변경하고싶어요
UPDATE employees
SET 
	`name` = '미어캣'
	, gender = 'M'
WHERE
	emp_id = 100005
;
-- 주의해야할점이잇음 WHERE 빼먹으면 안됨 전부다 갱신될 위험이있음..


-- 실습
-- 100006번 사원의 생일을 '2020-07-18',
-- 이름을 '마이콜'로 변경해주세요
UPDATE employees
SET
	`name` = '마이콜'
	,birth = '2020-07-18'
WHERE
	emp_id = 100006
;