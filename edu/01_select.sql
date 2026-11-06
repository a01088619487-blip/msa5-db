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

-- 1990년생인 사원을 조회해 주세요. → 1990-01-01~1990-12-31  
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
;

-- 이름이 '도성훈'or '정유리' 인 사원을 조회해 주세요
SELECT
	*
FROM employees
WHERE
	`name` = '도성훈'
	OR `name` = '정유리'
;

-- 1990년생 이거나, 이름이 '정유리'인 사원을 조회해주세요.
SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
	OR `name` ='정유리'
;
-- 데이터가 이상하게 나온걸 확인할 수 있다 그래서 묶어서 사용할때는
SELECT
	*
FROM employees
WHERE
(	
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
)    
	OR `name` ='정유리'
;
-- 이렇게 괄호를 넣어서 사용하기 
 -- 근데결과는 다르게나옴..흠 
 

SELECT *
FROM employees
WHERE birth >= '1990-01-01'
  AND birth <= '1990-12-31'
  AND `name` = '정유리';


 -- BETWEEEN 연산자 : 지정한 범위 내의 데이터를 조회
 SELECT
	*
FROM employees
WHERE
	birth >= '1990-01-01'
	AND birth <= '1990-12-31'
;

-- 위에잇는 연산자를 비트윈으로 바꿀꺼임
 SELECT
	*
FROM employees
WHERE
-- birth >= '1990-01-01'
-- AND birth <= '1990-12-31'
	birth BETWEEN '1990-01-01' AND '1990-12-31'
;

-- IN 연산자 : 다수의 지정한 값과 일치하는 데이터 조회
SELECT
	*
FROM employees
WHERE 
--	`name` = "박보람"
--	OR `name` = "정유리"
	`name` IN ('박보람','정유리')	
;

-- 사번이 1001, 1005 , 1006 인 사원의 모든 정보 조희
SELECT
	*
FROM employees
WHERE
	emp_id IN('1001',' 1005', '1006')
;

-- LIKE 절 : 문자열의 내용을 조회
-- % : 글자수와 상관없이 조회할 경우 사용
-- 이름이 '우'로 끝나는 사원 조회
SELECT
	*
FROM employees
WHERE
	`name` LIKE '%우'
;
-- 이름이 우로 시작하는 사원 조회시  --`name` LIKE '우%'
-- 이름에 우가 포함되어있는 사원 조회  --`name` LIKE '%우%' 


-- _ : ”_”(언더바)의 개수 만큼 글자수를 허용해서 조회
-- 이름이 '우' 앞에 1글자, 뒤에 1글자인 사원 조회 조회
SELECT 
	*
FROM employees
WHERE
	`name` LIKE '_우_'   -- 조합방법 : 두번째글가자 우인사람만 나오게된다. 뒤에가 몇글자든!
;

-- ORDER BY 절 : 조회한 데이터를 정렬하는 처리
-- 정렬한것처럼 보이는 이유는 선생님께서 정보를 순서대로 넣어서 정렬 된것처럼 보인거
-- 일반적으론 뒤섞여잇다.
-- 이름의기준으로  오름차순으로 하고싶을때
SELECT 
	*
FROM employees
ORDER BY `name` ASC   -- ASC 생략가능
;

-- 내림차순 -- ORDER BY `name` DESC
SELECT 
	*
FROM employees
ORDER BY `name`,birth   
;
-- 1순위 네임이라서 네임 기준으로 2순위인 생일을 정렬한다.

-- LIMIT절[개수] ,OFFSET절[건너뛸 행의 개수]: 출력의 개수를 제한
-- 키워드 같이쓰인다..차이읎음.
-- OFFSET기본값이 '0' -> '0'으로 지정하면 출력값이 '1' 부터 출력된다
SELECT
	*
FROM employees
-- LIMIT 5 OFFSET 7
LIMIT 7, 5
;

-- 집계 함수
-- SUM (컬럼) : 조회 된 해당 컬럼의 모든 값의 합계를
-- 반환하는 함수
-- 전 사원의 현재 급여 합계를 조회해주세요.
SELECT
	SUM(salary)  -- sum_sal 로 변경해줘서 사용한다 별칭이용해서
FROM salaries
WHERE
	end_at IS NULL
; 

-- MAX (컬럼)
SELECT
	MAX(salary)  
FROM salaries
WHERE
	end_at IS NULL
; 
-- Min (컬럼)

SELECT
	MIN(salary)  
FROM salaries
WHERE
	end_at IS NULL
; 
-- AVG (컬럼)
SELECT
	AVG(salary)  
FROM salaries
WHERE
	end_at IS NULL
; 

-- COUNT (컬럼)
-- 현재 재직중인 사원 수를 구해주세요.
SELECT 
	COUNT(*) cnt
FROM employees
WHERE
	fire_at IS NULL
;

-- DISTINCT 키워드 : 검색결과에서 중복되는 레코드 없이 출력
-- 사원이름을 가져올거임
SELECT DISTINCT
	`name`
FROM employees
-- ORDER BY `name`  생략 가능
;

-- GROUP BY 절, HAVING 절 : 그룹으로 묶어서 조회
-- 부서별 사원수 ?
SELECT 
	-- SELECT 절에 작성하는 컬럼은
	-- GRUP BY 절에서 사용한 컬럼과
	-- 집계 하람수만 작정해야하한다.(SQL 표준 문법)
	
	COUNT(dept_emp_id) cnt_emps, dept_code
FROM department_emps
WHERE 
	end_at IS NULL
GROUP BY dept_code
;

-- 직급별 사원수가 10000명 이상인 직급을 조회해주세요.
SELECT
   title_code
   , COUNT(*) cnt
FROM title_emps
WHERE
	end_at IS NULL 
GROUP BY title_code
	HAVING cnt >= 10000
;
	
 



--  쿼리 작성 순서 기본틀
-- SELECT [DISTINCT] [컬럼명]
-- FROM [테이블명]
-- WHERE [쿼리 조건]
-- GROUP BY [컬럼명] HAVING [집계함수 조건]
-- ORDER BY [컬럼명 ASC || 컬럼명 DESC]
-- LIMIT [n] OFFSET [n]
-- ;