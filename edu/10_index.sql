-- ---------------
-- INDEX
-- ---------------
-- INDEX 확인 -조회
-- SHOW  TABLES; 도잇음
-- 	SHOW INDEX FROM 테이블;
SHOW  INDEX FROM  employees;

SELECT * FROM employees WHERE `name` = '이미경' ;

-- INDEX 생성
-- 	ALTER TABLE 테이블 ADD INDEX 인덱스명 (인덱스 부여 컬럼);
-- 	ALTER TABLE 테이블 ADD INDEX 인덱스명 (인덱스 부여 컬럼1, 인덱스 부여 컬럼2...);
ALTER TABLE employees
ADD INDEX idx_employees_name(`name`);


-- INDEX 제거
-- DROP INDEX 인덱스명 ON 테이블;
ALTER TABLE employees
DROP INDEX idx_employees_name;