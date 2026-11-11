-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
	-- emp.emp_id, emp.name , tit.title.code		
	SELECT 
		emp.emp_id
		, emp.`name`
		, tits.title_code
	FROM  employees emp
	JOIN (titles tits
		JOIN title_emps tit 
			ON tits.title_code = tit.title_code 
				AND tit.end_at IS NULL )
			ON emp.emp_id =tit.emp_id			
				AND emp.fire_at IS NULL
	ORDER BY tit.title_code IS NULL,  tits.title_code 
	;	

	-- 다른방법
	SELECT 
		emp.emp_id
		, emp.`name`
		, tite.title_code
	FROM employees emp
		JOIN title_emps tite
			ON emp.emp_id = tite.emp_id
	WHERE
		emp.fire_at IS NULL	
		AND tite.end_at IS NULL	
	;
	
	-- 두번째에 다른방법? 
	SELECT 
		emp.emp_id
		, emp.`name`
		, tite.title_code
	FROM employees emp
		JOIN title_emps tite
			ON emp.emp_id = tite.emp_id
		AND emp.fire_at IS NULL	
		AND tite.end_at IS NULL	
	;
	
	
	

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
-- emp.emp_id , emp.gender ,sal.salary
	SELECT
		emp.emp_id
		,emp.gender
		,sal.salary
	FROM employees emp
		JOIN salaries sal
			ON emp.emp_id = sal.emp_id
				AND sal.end_at IS NULL
				AND emp.fire_at IS NULL	
	;


-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
-- emp.name, sal.salary ,과거 sal.start_at ,현재sal.end_at
	SELECT
		emp.`name`
		,sal.salary
		,sal.start_at
		,sal.end_at
	FROM employees emp
		JOIN salaries sal
			ON emp.emp_id = sal.emp_id
	WHERE emp.emp_id = 10010
--	ORDER BY sal.start_at 굳이 안줘도 되는거 같다 ㅇ.ㅇ
	;
	
	
	-- 다른방법
	
	SELECT 
		emp.`name`
		,sal.salary
		,sal.start_at
		,sal.end_at
	FROM salaries sal
		JOIN employees emp
			ON	sal.emp_id =emp.emp_id
				AND emp.emp_id = 10010
	;
	
-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
--  emp.emp_id ,  emp.`name`, dep.dept_name
	SELECT 
		emp.emp_id
		, emp.`name`
		,dep.dept_name
	FROM employees emp
		JOIN department_emps depe
			ON emp.emp_id = depe.emp_id
				AND emp.fire_at IS NULL
		JOIN departments dep
			ON depe.dept_code = dep.dept_code
				AND depe.end_at IS NULL
	;
	

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
-- emp.emp_id ,  emp.`name`, sal.salary ,  LIMIT 10, 
--  DESC: 내림차순 (큰 것 → 작은 것, 최근 → 과거)
	
	SELECT 
		emp.emp_id
		, emp.`name`
		, sal.salary
	FROM employees emp
		JOIN salaries sal
			ON emp.emp_id = sal.emp_id
				AND sal.end_at IS NULL	
	ORDER BY sal.salary DESC   -- 믕청이 그룹으로 하고말이여 =ㅅ=;
	LIMIT 10
	;
	
	-- 정확도 
	SELECT 
		emp.emp_id
		, emp.`name`
		, sal.salary
	FROM employees emp
		JOIN salaries sal
			ON emp.emp_id = sal.emp_id
				AND emp.fire_at IS NULL	    -- 이걸 넣어야 확실하게 나옴! 
				AND sal.end_at IS NULL
	ORDER BY sal.salary DESC    
	LIMIT 10
	;	
	-- 속도 개선 버전  (공간 복잡도는 증가할 수 있음 )
	SELECT
		emp.emp_id
		,emp.`name`
		,tmp_sal.salary
	FROM employees emp
		JOIN (
			SELECT
				sal.emp_id
				,sal.salary
			FROM salaries sal
			
			WHERE
				sal.end_at IS NULL
			ORDER BY sal.salary DESC
			LIMIT 10
		) tmp_sal
			ON emp.emp_id = tmp_sal.emp_id
				AND emp.fire_at IS NULL
	ORDER BY tmp_sal.salary DESC
	;	

	
	
-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
-- dep.dept_name , emp.`name`, emp.hire_at

	SELECT 
		dep.dept_name
		, emp.`name`
		, emp.hire_at
	FROM  employees emp
	 JOIN (departments dep
		JOIN department_emps depe
			ON dep.dept_code = depe.dept_code
				AND dep.end_at IS NULL )
			ON emp.emp_id = depe.emp_id		
				AND emp.fire_at IS NULL
	ORDER BY dep.dept_code -- 순서대로 출력
	;	
	-- 내껀틀린 정보 ㅠ.. 부서의 부서장이 안나옴 ㅠㅠ
	-- "부서원" → department_emps
	-- "부서장" → department_managers
	
	 
	-- 그래서 내방식으로 고치면
	
	SELECT 
		dep.dept_name
		, emp.`name`
		, emp.hire_at
	FROM  employees emp
	 JOIN (departments dep
		JOIN department_managers depm
			ON dep.dept_code = depm.dept_code
				AND dep.end_at IS NULL
				AND depm.end_at IS NULL -- 추가: 현재 부서장만
				 )
			ON emp.emp_id = depm.emp_id		
				AND emp.fire_at IS NULL
	ORDER BY dep.dept_code 
	;
	
	
	-- 다른 정답! 
	SELECT 
		dep.dept_name
		, emp.`name`
		, emp.hire_at
	FROM employees emp
		JOIN department_managers depm
			ON emp.emp_id = depm.emp_id
				AND depm.end_at IS NULL
				AND emp.fire_at IS NULL
		JOIN departments dep
		ON dep.dept_code = depm.dept_code
			AND dep.end_at IS NULL	
	;	
		

-- 7. 현재 직급이 "부장"인 사원들의 각각 연봉 평균을 출력해 주세요.
-- title_empse - title_code: T005 인 연봉 평균 AVG(salaries)
	
	-- 이게 연봉 평균
	SELECT 
		(SELECT 
			AVG(sal.salary)  avgsal
		FROM salaries sal
			WHERE sal.emp_id = emp.emp_id
		)avg_sal
	FROM employees emp
	;
	
	-- 부장만!
	SELECT
		tite.title_code
	FROM employees emp
		JOIN title_emps tite
			ON emp.emp_id = tite.emp_id
	WHERE tite.title_code = 'T005'
	;

  -- 이걸 합쳐! 야 하는뎅...
	SELECT 
		emp.emp_id
		,(SELECT 
			AVG(sal.salary)
		FROM salaries sal
			WHERE sal.emp_id = emp.emp_id
			AND emp.fire_at IS NULL 
		)avg_sal		
	FROM employees emp 
		JOIN(     -- left join을 해서 코드번호에 null이 나옴.
			SELECT
				emp.emp_id
				,tite.title_code
			FROM employees emp
				JOIN title_emps tite
				ON emp.emp_id = tite.emp_id
			WHERE tite.title_code = 'T005'
				AND emp.fire_at IS NULL
		)tmp_title
		ON emp.emp_id = tmp_title.emp_id 
		WHERE emp.fire_at IS NULL 
		ORDER BY emp.emp_id ASC
	;
	
	
	-- 고치면
	SELECT
    emp.emp_id
    , (SELECT AVG(sal.salary)
       FROM salaries sal
       WHERE sal.emp_id = emp.emp_id
      ) avg_sal
	FROM employees emp
		JOIN (
        SELECT tite.emp_id
        FROM title_emps tite
        JOIN titles tit
            ON tite.title_code = tit.title_code
            AND tit.title = '부장'
            AND tite.end_at IS NULL  -- tite.end_at IS NULL 추가 → 현재 부장만
    ) tmp_title					-- emp.fire_at IS NULL 제거 → 정답과 같은 기준 (문제에서 재직자만 요구하면 다시 넣으세요)
  	-- 'T005'를 직접 쓰는 건 코드가 바뀌면 틀릴 수 있어서, 정답처럼 title = '부장'으로 titles를 조인하는 방식이 더 안전
    	ON emp.emp_id = tmp_title.emp_id 
	ORDER BY emp.emp_id
	;
	
	
	

	-- 이게정답.
	SELECT 
		tite.emp_id
		, AVG(sal.salary) avg_sal
	FROM title_emps tite
		JOIN titles tit
			ON	tite.title_code = tit.title_code
				AND tit.title = '부장'
				AND tite.end_at IS NULL
		JOIN salaries sal
			ON tite.emp_id = sal.emp_id
	GROUP BY tite.emp_id
	ORDER BY tite.emp_id  -- 정렬 
	;		
	

-- and 해서도 like 가능함~ 조인할때 ㅜ멍?'

	

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
-- emp.`name` , AVG(sal.salary) --부장 그룹 ?__
		SELECT 
		emp.`name`
		,(SELECT 
			AVG(sal.salary)
		FROM salaries sal
			WHERE sal.emp_id = emp.emp_id
			AND emp.fire_at IS NULL 
		)avg_sal		
	FROM employees emp 
		JOIN(    
			SELECT
				emp.emp_id
				,tite.title_code
			FROM employees emp
				JOIN title_emps tite
				ON emp.emp_id = tite.emp_id
			WHERE tite.title_code = 'T005'
				AND emp.fire_at IS NULL
		)tmp_title
		ON emp.emp_id = tmp_title.emp_id 
		WHERE emp.fire_at IS NULL 
		GROUP BY emp.emp_id ,emp.`name`
	;
	
	-- 내껄 고치면 ㅠ
	SELECT
	    emp.emp_id
	    , emp.`name`
	    , (SELECT AVG(sal.salary)
	       FROM salaries sal
	       WHERE sal.emp_id = emp.emp_id
	      ) avg_sal
	FROM employees emp
	JOIN (
	        SELECT tite.emp_id
	        FROM title_emps tite
	        JOIN titles tit
	            ON tite.title_code = tit.title_code
	            AND tit.title = '부장'
	            AND tite.end_at IS NULL
	    ) tmp_title
	    ON emp.emp_id = tmp_title.emp_id
	WHERE emp.fire_at IS NULL
	ORDER BY emp.emp_id  --  추가 (재직 중인 부장만)
	;
	-- 내 방식은 GROUP BY가 필요 없는 게 장점이에요. 서브쿼리가 사원별로 알아서 평균을 구함
	-- 연봉 이력이 없는 부장이 있다면 정답은 그 사람이 아예 빠지고(INNER JOIN), 
	-- 내 쿼리는 avg_sal이 NULL로 나온다. 건수가 다르면 이 경우를 의심..


	-- 정답
		SELECT 
		tite.emp_id
		, emp.`name`
		, AVG(sal.salary) avg_sal
	FROM title_emps tite
		JOIN titles tit
			ON	tite.title_code = tit.title_code
				AND tit.title = '부장'
				AND tite.end_at IS NULL
		JOIN salaries sal
			ON tite.emp_id = sal.emp_id
		JOIN employees emp
			ON emp.emp_id = tite.emp_id
				AND emp.fire_at IS NULL 
	GROUP BY tite.emp_id
	ORDER BY tite.emp_id  -- 정렬 
	;	

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
-- emp.`name` , emp.hrire_at , emp.emp_id , dep.dept_code

	SELECT
		emp.`name` 
		, emp.hire_at 
		, emp.emp_id 
		, depm.dept_code
	FROM employees emp
		JOIN department_managers depm
		ON emp.emp_id =depm.emp_id
			AND emp.fire_at IS NULL
	;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
-- title_emps.title , AVG(sal.salary), DESC: 내림차순
	SELECT 
		 tit.title
		, AVG(sal.salary) avg_sal   --  정수 CEIL(AVG(sal.salary)) CEIL 빼먹음.
	FROM title_emps tite
		JOIN 	titles tit
			ON tite.title_code = tit.title_code
		 AND tite.end_at IS NULL
		JOIN salaries sal
			ON tite.emp_id = sal.emp_id
			AND sal.end_at IS NULL
	GROUP BY tit.title_code
	HAVING avg_sal >= 60000000 -- 정수 CEIL(AVG(sal.salary)) 일시  HAVING AVG(sal.salary) >= 60000000 교체
	ORDER BY avg_sal DESC 
	; 	
	
	-- 다른방식 
	SELECT 
		tit.title
		, tite.title_code
		, CEIL(AVG(sal.salary)) avg_sal
	FROM title_emps tite
		JOIN titles tit 
			ON tite.title_code = tit.title_code
		JOIN salaries sal
			ON tite.emp_id = sal.emp_id
				AND sal.end_at IS NULL
				AND tite.end_at IS NULL	 -- 여기 까지 연봉  나랑 여기서 다르넹 ㅇ..ㅇ 이게 어디에도 순서를 가도 괜찮은건가?
	GROUP BY tit.title_code , tit.title 	-- 급여 평균
	HAVING AVG(sal.salary) >= 60000000
	ORDER BY avg_sal DESC 		
	;


-- 여기서부턴 못풀엇음 ㅠ^ㅠ

-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
-- emp.gender , tite->titles.title_code 에... count 를 해얗는ㄷ..
	SELECT 
		tite.title_code
		, tit.title
		, COUNT(tite.emp_id) cnt  -- (*) 이건 null도 포함이 되서 안하는게좋다 
		-- -count(*)은...AND emp.fire_at IS NULL ,AND tite.end_at IS NULL ,AND emp.gender = 'F' 의 묶엇는데도 안되나보넹 
	FROM employees emp
		JOIN title_emps tite
			ON emp.emp_id = tite.emp_id
				AND emp.fire_at IS NULL
				AND tite.end_at IS NULL
				AND emp.gender = 'F'
	-- 그룹핑할때 하는법
		JOIN titles tit
			ON tit.title_code = tite.title_code		
	GROUP BY tite.title_code 
	ORDER BY tite.title_code
	;			
	


-- ------------------------------
-- 전체 평균 급여보다 높은 급여를 받은 기록을 조회

	



-- 가장 높은 급여를 받은 이력이있는 사원의 사번과 급여를 조회