-- -----------------
-- join문
-- 복수의 테이블 묶어서 하나의 결과 집합으로 츌력
-- -----------------
-- 전 사원의 사번, 이름, 현재급여를 출력해주세요
-- emi_id(많은곳에있음) , `name`(emp), salriese(salaries)
SELECT 
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees   emp
 JOIN  salaries   sal   -- join의 정칙으로는  'INNER JOIN' 로 쳐야함
	ON emp.emp_id = sal.emp_id  -- 2개이상의 연결할때 지정하는처리
	AND sal.end_at IS NULL
;


											-- WHERE -- 팔터링 조건
											-- HAVING -- 그룹핑의 할때 집계치
-- 다른 방식 옛버전의 join !
SELECT 
	emp.emp_id
	, emp.`name`
	, sal.salary
FROM employees   emp, salaries   sal 
WHERE emp.emp_id = sal.emp_id  -- 추가로 할땐 AND 해두기 
	AND sal.end_at IS NULL
;
-- ------------------------------	


				
-- -----------------
-- INNER JOIN  ( 제일 많이 쓰임)
-- 복수의 테이블이 공통적으로 만족하는 레코드를 출력
-- -----------------

-- 재직중인 사원의 사번, 이름, 생일, 부서명
-- emp.emp_id, emp.`name`,emp.birth, depe.
--  부서명->소속부서테이블에서 부서테이블로 가야함 (바로 연결 하는 수단이없기때문에 연결고리로.)

SELECT 
	emp.emp_id
	, emp.`name`
	, emp.birth
	, dep.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS NULL
	JOIN departments dep
		ON depe.dept_code = dep.dept_code
			AND depe.end_at IS NULL
;



-- -----------------
-- LEFT & RIGHT OUTER JOIN
-- -----------------
-- 재직중인 전 사원 정보를 출력하는데, 현재 부서장안 사원이면
-- 부서장 정보도 같이 출력해주세요 --> 전사원 정보 다 출력하고 부서장도 같이 주라~
SELECT
	 emp.emp_id
	,emp.`name`
	,depm.dept_code
FROM employees emp
	LEFT JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL
			AND depm.end_at IS NULL
	RIGHT JOIN departments dep
		ON dep.dept_code = depm.dept_code   
--  아래에 두면 사원 안나오게됨 실행순서가 위에서 아래로이기때문 근데 Right를 넣엇는데도 안나옴
-- 이유눈 왼족 기준 + 우측 기준 다로 따로 이므로?
ORDER BY depm.dept_code DESC 
;

SELECT * FROM department_managers WHERE end_at IS NULL;  -- 확인


-- 우측이 아니라 왼쪽으로 햇으면 가능햇넹!
SELECT
	 emp.emp_id
	,emp.`name`
	,depm.dept_code
	,dep.dept_name
FROM employees emp
	LEFT JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL
			AND depm.end_at IS NULL
	LEFT JOIN departments dep
		ON dep.dept_code = depm.dept_code   
	 ORDER BY depm.dept_code DESC 
--	ORDER BY depm.dept_code IS NULL, depm.dept_code  -- null을 밑으로 정렬?? 맞는건가?.. 차이가없는데 
;



-- 이걸 제대로 쓰고시프면
-- 부서 테이블 과 부서매니저테이블을 먼저 이어주고 사원정보테이블이랑 엮어아함
-- 이대 좋은게 서브쿼리를 써야함!
SELECT 
	emp.emp_id
	,emp.`name`
	, tmp_manager.dept_code
	, tmp_manager.dept_name
FROM employees emp
	LEFT JOIN (
	SELECT
		depm.emp_id
		, dep.dept_code
		, dep.dept_name
	FROM departments dep 
		JOIN department_managers depm
		ON dep.dept_code = depm.dept_code
			AND depm.end_at IS NULL
	) tmp_manager
		ON emp.emp_id = tmp_manager.emp_id
			AND emp.fire_at IS NULL 
ORDER BY tmp_manager.dept_code DESC
;


-- 또다른 방법..
SELECT
	 emp.emp_id
	,emp.`name`
	,depm.dept_code
	,dep.dept_name
FROM employees emp
	LEFT JOIN (department_managers depm
		JOIN departments dep 
			ON dep.dept_code = depm.dept_code 
				AND depm.end_at IS NULL )
		ON emp.emp_id =depm.emp_id			
			AND emp.fire_at IS NULL
ORDER BY depm.dept_code IS NULL,  depm.dept_code
;


-- -----------------
-- XXX  FULL OUTER JOIN  XXXXX
-- -----------------


-- -----------------
-- UNION
-- 두개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION   (중복 레코드를 제거)
-- UNION ALL (중복 레코드를 제거 안함)
-- -----------------
SELECT * FROM employees WHERE emp_id IN (1,3)
UNION
SELECT * FROM employees WHERE emp_id IN (1,5)
;

SELECT * FROM employees WHERE emp_id IN (1,3)
UNION ALL
SELECT * FROM employees WHERE emp_id IN (1,5)
;


SELECT *, '1' FROM employees WHERE emp_id IN (1,3)
UNION
SELECT *, '2' FROM employees WHERE emp_id IN (1,5)
;

-- -----------------
-- SELF JOIN
-- 같은 테이블 끼리 조언
-- -----------------
-- 현재 슈퍼바이저인 사원 정보 출력
SELECT
	emp.emp_id junior_emp_id
	,emp.`name` junior_name
	,sup.emp_id sup_id
	,sup.`name`	sup_name
FROM employees emp
	JOIN  employees sup
		ON emp.sup_id = sup.emp_id
			AND emp.sup_id IS NOT NULL
;

x


