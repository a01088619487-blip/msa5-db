-- SubQuery
-- 아이고난...
-- 속도 저하 발생할 가능성이 높다
--  -----------------------
--	 WHERE 절에서 사용
--  -----------------------
-- 단일 행 서브 쿼리
-- 서브쿼리가 단일행 비교 연산자와 함께 사용할 때는
-- 반드시 서브쿼리의 결과 수가 1건 이하여야 한다.
-- 만약에 2건 이상일 경우 오류가 발생

-- D001 부서장의 사번과 이름을 출력
-- 전에껄로는 확인이 불가능하지만 서브쿼리를 같이 이용함
-- 서브쿼리으로써 사용이 가능해졌음. 
SELECT
	emp.emp_id -- emp_id만 적으면 어떤 테이블의 empid라는거 알려주는것
	,emp.`name`
FROM employees emp   -- emp 라는 별칭 수여 (이제 쿼리 2개이상 사용하므로)
WHERE
	emp.emp_id =(
		SELECT
			depm.emp_id
		FROM department_managers depm -- 별칭수여 depm
		WHERE
			dept_code = 'D001'
		AND end_at IS NULL
	)
;


--  이 걸 저기 위에..합치기..
-- `D001`의 현재 부서장 사번
SELECT
	emp_id
FROM department_managers
WHERE
	dept_code = 'D001'
	AND end_at IS NULL
;

-- 다중 행 서브쿼리
-- 서브 쿼리의 결과가 2건 이상을 반환할 경우
-- 반드시 다중 행 비교연산자(IN,ALL,ANY,SOME,ECISTS 등)를 이용해야한다 
-- 현재 부서장인 사원의 사번과 이름을 출력
SELECT 
	depm.emp_id
FROM department_managers depm
WHERE
	depm.end_at IS NULL
;
-- 위에껄 아래로 옮겨서!
SELECT
	emp.emp_id
	,emp.`name`
FROM employees emp
WHERE
	emp.emp_id IN (
		SELECT 
			depm.emp_id
		FROM department_managers depm
		WHERE
			depm.end_at IS NULL
	)
;

-- 다중 열 서브쿼리
-- 현재 'D002' 부서장이 해당 부서에 소속 된 날짜를 출력
SELECT
	depe.start_at
FROM department_emps depe
WHERE
	(depe.emp_id, depe.dept_code) IN(  -- IN 연산자로 비교
		SELECT
			depm.emp_id
			,depm.dept_code
		FROM department_managers depm
		WHERE
			depm.dept_code = 'D002'
			AND depm.end_at IS NULL
	)
;
--	depe.emp_id = 571
--	AND depe.dept_code = 'D002'

-- 이 밑에 값을 위로
SELECT
	depm.emp_id
	,depm.dept_code
FROM department_managers depm
WHERE
	depm.dept_code = 'D002'
	AND depm.end_at IS NULL
;


-- 연관 서브 쿼리
-- 서브쿼리 내에서 메인쿼리의 컬럼이 사용된 서브쿼리
-- 부서장직을 지냈던 경력이 있는 사원의 정보를 출력
SELECT
	emp.*
FROM employees emp
WHERE
	emp.emp_id IN(
		SELECT 
			depm.emp_id
		FROM department_managers depm
		WHERE 
		depm.emp_id = emp.emp_id
	)
;


--  -----------------------
--	 SELECT 절에서 사용
--  -----------------------
-- 사원별 역대(과거포함) 전체 급여 평균
SELECT
	emp.emp_id
	,	(
		SELECT 
			AVG(sal.salary)
		FROM salaries sal
		WHERE sal.emp_id = emp.emp_id
		) agv_sal
FROM employees emp
;


--  -----------------------
--	FROM 절에서 사용
--  -----------------------
SELECT 
	tmp.*
FROM (
	SELECT 
		emp.emp_id
		,emp.`name`
	FROM employees emp
	WHERE 
		fire_at IS NOT NULL -- 퇴사자
)tmp
;


--  -----------------------
--	 INSERT 문에서 사용
--  -----------------------

INSERT INTO employees (
	employees.emp_id
	,employees.`name`
	,employees.birth
	,employees.gender 
	,employees.hire_at
)
VALUES (
	(SELECT MAX(emp_id) + 1 FROM employees emp)  
	,'둘리'
	,'1980-01-01'
	,'M' 
	,NOW()
)
; 


--  -----------------------
--	 UPDATE 문에서 사용
--  -----------------------
-- 퇴사한 사원의직급 테이블의 직급 종료일을
-- 퇴사일로 갱신해주세요.

UPDATE title_emps
SET 
	title_emps.end_at = (
		SELECT employees.fire_at
		FROM employees
		WHERE
		 employees.emp_id = 100011
	)
WHERE 
	title_emps.emp_id = 100011
	AND title_emps.end_at IS NULL 
;



--  -----------------------
--	
--  -----------------------



