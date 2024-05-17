-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
SELECT count(*)
FROM salaries
WHERE salary > (SELECT avg(salary)
				FROM salaries
                WHERE to_date = '9999-01-01')
AND to_date = '9999-01-01';

-- 문제2.  XXXX
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요.
SELECT a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', b.salary as '연봉'
FROM employees a, salaries b, dept_emp c,
	(SELECT b.dept_no, avg(a.salary) as avg_sal
	 FROM salaries a, dept_emp b, employees c
	 WHERE a.emp_no = b.emp_no
	 AND b.emp_no = c.emp_no
	 AND a.to_date = '9999-01-01'
	 AND b.to_date = '9999-01-01'
	 GROUP BY b.dept_no) d
WHERE a.emp_no = b.emp_no
AND b.emp_no = c.emp_no
AND b.to_date = '9999-01-01'
AND c.to_date = '9999-01-01'
AND b.salary > d.avg_sal
AND c.dept_no = d.dept_no;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 담당 매니저 이름, 부서 이름으로 출력해 보세요.
SELECT a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', d.man_name as '매니저 이름', c.dept_name as '부서 이름'
FROM employees a, dept_emp b, departments c,
	(SELECT concat(a.first_name, ' ', a.last_name) as man_name, b.emp_no as emp_no, b.dept_no as dept_no
	FROM employees a, dept_manager b 
    WHERE a.emp_no = b.emp_no
    AND b.to_date = '9999-01-01') d
WHERE a.emp_no = b.emp_no
AND b.dept_no = c.dept_no
AND b.dept_no = d.dept_no
AND b.to_date = '9999-01-01'
ORDER BY a.emp_no;

SELECT concat(a.first_name, ' ', a.last_name) as man_name, b.emp_no as emp_no, b.dept_no as dept_no
	FROM employees a, dept_manager b 
    WHERE a.emp_no = b.emp_no
    AND b.to_date = '9999-01-01';

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
SELECT a.emp_no as '사번', concat(a.first_name, ' ', a.last_name) as '이름', b.title as '직책', c.salary as '연봉'
FROM employees a, titles b, salaries c, dept_emp d
WHERE a.emp_no = b.emp_no
AND b.emp_no = c.emp_no
AND c.emp_no = d.emp_no
AND b.to_date = '9999-01-01'
AND c.to_date = '9999-01-01'
AND d.to_date = '9999-01-01'
AND d.dept_no = (SELECT a.dept_no
				FROM dept_emp a, salaries b
				WHERE a.emp_no = b.emp_no
				GROUP BY a.dept_no
				ORDER BY avg(b.salary) DESC
				LIMIT 0, 1)
ORDER BY c.salary DESC;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
-- 부서이름, 평균급여 
SELECT c.dept_name as '부서이름', avg(b.salary) as '평균급여'
FROM dept_emp a, salaries b, departments c
WHERE a.emp_no = b.emp_no
AND a.dept_no = c.dept_no
AND b.to_date = '9999-01-01'
GROUP BY a.dept_no
ORDER BY avg(b.salary) DESC
LIMIT 0, 1;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
-- 직책, 평균급여 
SELECT b.title as '직책', avg(a.salary) as '평균급여'
FROM salaries a, titles b
WHERE a.emp_no = b.emp_no
AND a.to_date = '9999-01-01'
AND b.to_date = '9999-01-01'
GROUP BY b.title
ORDER BY avg(a.salary) DESC
LIMIT 0, 1;

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
SELECT b.dept_name as '부서이름', concat(c.first_name, ' ', c.last_name) as '사원이름', d.salary as '연봉', e.man_name as '매니저 이름', e.salary as '매니저 연봉'
FROM departments b, employees c, salaries d, dept_emp a,
	(SELECT concat(a.first_name, ' ', a.last_name) as man_name, b.dept_no as dept_no, c.salary as salary
	 FROM employees a, dept_manager b, salaries c
     WHERE a.emp_no = b.emp_no
     AND a.emp_no = c.emp_no
     AND b.to_date = '9999-01-01'
     AND c.to_date = '9999-01-01') e
WHERE a.dept_no = b.dept_no
AND a.emp_no = c.emp_no
AND c.emp_no = d.emp_no
AND a.to_date = '9999-01-01'
AND d.to_date = '9999-01-01'
AND d.salary > e.salary
ORDER BY e.salary DESC;