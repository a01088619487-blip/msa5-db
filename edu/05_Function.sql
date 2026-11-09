-- 내장 함수(Function)
-- 데이터를 처리하고 분석하는데 사용하는 프로그램 
-- ----------------------
-- 데이터 타입 변환 함수
-- ----------------------

SELECT
	1234
	, CAST(1234 AS CHAR (6)) -- 이걸 캐릭터 여섯글자로 바꾸고싶옹 가능
	, CONVERT(1234, CHAR (6) ) -- 현재는 결과는 같다 
;
SELECT 
	CAST(emp_id AS CHAR (30))
FROM employees
;

-- ----------------------
-- 제어 흐름 함수
-- ----------------------
-- IF(수식, 참일 경우의 갑스 거짓일 경우의 값)
SELECT
	`name`
	, gender
	, IF(gender = 'M', '남자','여자') ko_gender
FROM employees
;

-- IFNULL (수식1, 수식2)
-- 수식1이 null 이면 수식2를 반환 아니면 수식 1을 반환
SELECT
	IFNULL(fire_at,'재직중')
	,fire_at
FROM employees
;	

-- NULLIF(수식1,수식2)
-- 수식1과 수식2를 비교해서 같으면 NUL을 반환
-- 다르면 수식1을 반환
SELECT
	NULLIF(gender,'M')
FROM employees
;

-- CASE ~ WHEN ~ ELSE ~ END 
SELECT
	CASE gender
		WHEN 'M' THEN '남자'
		WHEN 'F' THEN '여자'
		ELSE '기타'	
	END ko_gebder
FROM employees
;

-- ----------------------
-- 문자열 함수
-- ----------------------
-- 문자열 연결 
SELECT CONCAT ('안녕',' ','하세요.');
SELECT CONCAT (`name`, ' ', gender ) FROM employees;

-- 구분자로 문자열을 연결
SELECT CONCAT_WS(', ','자바 ','JS', 'HTML');  

-- 숫자에 자릿수 (,) 및 소수점 자리수 표시
SELECT FORMAT(salary, 0 ) FROM salaries;

-- 문자열의 왼/오른쪽부터 길이만큼 잘라 반환
SELECT LEFT('123456',2)
, RIGHT('123456',2)
;

-- 문자열의 좌/우에 문자열 길이만큼 채울 문자열을 삽입
SELECT LPAD('123',6,'★'), RPAD('123',6,'0');

-- 문자열 좌/우 공백을 제거
SELECT
'        test   '
	,TRIM('        test   ')
	,LTRIM('        test   ')
	,RTRIM('        test   ')
;

-- 문자열을 시작위치에서 길이만큼 잘라서 반환
SELECT SUBSTRING('123456',3,2);

-- 왼쪽부터 구분자가 n번째 만큼 나오면 그 이후를 버림
SELECT SUBSTRING_INDEX(
	'abc_test_123.txt'
	,'_'
	, 2
) txt;

-- 영어 대/소문자 변경
SELECT UPPER('ASDwdsaSDwdxxWE'), LOWER('sadWDASQcdawdwSEESE');




-- ----------------------
-- 수학 함수
-- ----------------------

-- 올림, 반올림, 버림
SELECT CEIL(3.14),ROUND(3.14) ,FLOOR(3.14);

-- 절대 값
SELECT ABS(-1), ABS(1);

-- 소수점을 기준으로 특정 자리수까지 구하고 나머지는 다 버림
SELECT TRUNCATE(1.1239,3);


-- ----------------------
-- 날짜 및 시간 관련 함수
-- ----------------------
-- 현재 날짜 및 시간 반환 (YYYY-MM-DD hh:mi:ss)
SELECT NOW();

SELECT DATE(NOW());
SELECT DATE(created_at) FROM employees;

-- 날짜의 단위기간에 따라 더한 날짜 /시간을 반환 
SELECT ADDDATE(NOW(),INTERVAL 1 YEAR) ;
SELECT ADDDATE(NOW(),INTERVAL -1 YEAR);
SELECT ADDDATE(NOW(),INTERVAL 1 MONTH) ;
SELECT ADDDATE(NOW(),INTERVAL 1 DAY) ;
SELECT ADDDATE(NOW(),INTERVAL 1 HOUR) ;
SELECT ADDDATE(NOW(),INTERVAL 1 MINUTE);
SELECT ADDDATE(NOW(),INTERVAL 1 SECOND);
SELECT ADDDATE(NOW(),INTERVAL 1 MICROSECOND);

SELECT ADDTIME(NOW(),'01:30:00');



-- ----------------------
-- 집계 함수 
-- ----------------------
-- 금요일 3일차에 했음 


-- ----------------------
-- 순차 함수 
-- ----------------------
-- RANK() OVER(ORDER BY 컬럼 ASC.DESC)
-- 지정한 컬럼을 기준으로 순위를 매겨 반환
-- 동일한 값이 있는 경우 동일한 순위 부여
SELECT
	emp_id
	,salary
	,RANK() OVER(ORDER BY salary DESC) `rank`
FROM salaries
WHERE
	end_at IS NULL
;

-- ROW_NUMBER() OVER(ORDER BY salary DESC/ASC)
-- 레코드에 순위를 매겨 반환
-- 동일한 값이 있는 경우에도 각 행에 고유한 번호를 부여
SELECT
	emp_id
	,salary
	,ROW_NUMBER() OVER(ORDER BY salary DESC, emp_id) `rank`
FROM salaries
WHERE
	end_at IS NULL
	AND salary >= 80000000
;
