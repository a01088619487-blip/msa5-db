-- DELETE문
-- DML 중 하나로 저장되어있는 
-- 기존 데이터를 삭제하기 위해 사용하는 쿼리
-- DELETE FROM 테이블명
-- [WHERE 조건];
DELETE FROM title_emps  -- FROM은 아직 적지말기.  조건을 적지않을 경우 모든 레코드가 삭제
WHERE 
	emp_id = 100006
;
DELETE FROM title_emps  
WHERE 
	start_at >= '2026-11-09'
;