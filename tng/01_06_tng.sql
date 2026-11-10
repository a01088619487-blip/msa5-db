-- 1. 직급테이블의 모든 정보를 조회해주세요.
	SELECT 
		*
	FROM titles
	;
	
	
-- 2. 현재 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
	SELECT 
		emp_id
		,salary
	FROM salaries
	WHERE 
	salary <= 60000000
	AND end_at IS NULL
	;
	  
-- 3. 현재 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
	SELECT
		emp_id
		,salary
	FROM salaries
	WHERE
		salary >=  60000000
		AND salary <= 70000000
		AND end_at IS NULL
		;
		
		-- 또 다른 방법
	SELECT
		emp_id
		,salary
	FROM salaries
	WHERE
			end_at IS null
		AND salary BETWEEN 60000000 AND 70000000
		;

-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
	SELECT
		*
	FROM employees
	WHERE 
	emp_id IN (10001, 10005);


-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
	SELECT 
		title_code
		,title
	FROM titles
	WHERE 
	 title LIKE '%사%'
	 ;
		

-- 6. 사원(퇴사자 포함) 이름 오름차순으로 정렬해서 조회해 주세요.
	SELECT
		`name`
	FROM employees
	ORDER BY `name` ASC
	;

-- 7. 사원별(퇴사자 포함)  전체 급여의 평균을 조회해 주세요.
	SELECT
		AVG(salary) avg_sal 
	FROM salaries
	;    -- 땡~~~ 사원별인데 빼버렷데용~_~
	
	SELECT 
		emp_id
		,CEIL(AVG(salary)) avg_sal  -- CEIL(00(00))로인하여 소수점삭제
	FROM salaries
	GROUP BY emp_id
	;

-- 8. 사원별(퇴사자 포함)  전체 급여의 평균이 30,000,000 ~ 50,000,000인,
--   사원번호와 평균급여를 조회해 주세요.
	SELECT 
		emp_id
		,AVG(salary) 
	FROM salaries
	GROUP BY emp_id
		HAVING AVG(salary) BETWEEN 30000000 AND 50000000
	;
		-- 	HAVING 집계치의 계산이므로 잘 구분하면서 쓰쟝

-- 9. 사원별(재직중인 사원) 전체 급여 평균이 70,000,000이상인,
--   사원의 사번, 이름, 성별을 조회해 주세요.

	SELECT
		emp.emp_id
		,emp.`name`
		,emp.gender
	FROM employees emp
	WHERE emp.fire_at IS NULL
	AND (
		SELECT
			AVG(sal.salary)
		FROM salaries sal
		WHERE sal.emp_id = emp.emp_id

	) >= 70000000
	;
	

	
	-- 또다른 방법~
	
	 
	SELECT
		emp.emp_id
		,emp.`name`
		,emp.gender
	FROM employees emp
	WHERE emp.emp_id IN(
		SELECT
		 		emp_id
		FROM salaries sal
	--	WHERE 
	--		end_at IS NULL 과거이력을 빼야함!
			GROUP BY sal.emp_id
			HAVING AVG(salary) >= 70000000
	) AND fire_at IS null
	;
	
	-- 이걸 이제 위에 붙여!
	SELECT 
		emp_id
	FROM salaries sal
	WHERE 
		end_at IS NULL
	GROUP BY sal.emp_id
		HAVING AVG(salary) >= 70000000;
	
	

-- 10. 현재 직급이 'T005'인,
--   사원(재직중인 사원) 의 사원번호와 이름을 조회해 주세요.
	SELECT 
		emp.emp_id
		,emp.`name`
	FROM employees emp
	WHERE 
		emp.fire_at IS null
		AND emp.emp_id IN (
		 SELECT  
		 	tit.emp_id
		 FROM title_emps tit
		 WHERE tit.title_code ='T005'
		 	AND tit.end_at IS NULL 
		)
	;
	

-- 또다른방법
	SELECT 
		emp.emp_id
		,emp.`name`
	FROM employees emp
	WHERE
		emp.emp_id IN (
			SELECT 
				tie.emp_id
			FROM title_emps tie
			WHERE 
				tie.title_code = 'T005'
				AND tie.end_at IS NULL 
		);
