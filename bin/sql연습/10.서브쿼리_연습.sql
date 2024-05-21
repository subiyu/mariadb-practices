--
-- subquery
--

--
-- 1) select 절, insert into t1 values(...)
--

--
-- 2) from 절의 서브쿼리
--
SELECT now() as n, sysdate() as s, 3 + 1 as r FROM dual;

SELECT n, s 
FROM (SELECT now() as n, sysdate() as s, 3 + 1 as r FROM dual) a;

--
-- 3) where 절의 서브쿼리
--

-- 예제) 현재, Fai Bale이 근무하는 부서에서 근무하는 다른 직원의 사번과 이름을 출력하세요.
SELECT *
FROM employees a, dept_emp b
WHERE a.emp_no = b.emp_no
AND b.to_date = '9999-01-01'
AND concat(a.first_name, ' ', a.last_name) = 'Fai Bale';

-- 'd004'
SELECT a.emp_no, a.first_name
FROM employees a, dept_emp b
WHERE a.emp_no = b.emp_no
AND b.to_date = '9999-01-01'
AND b.dept_no = (SELECT b.dept_no 
				FROM employees a, dept_emp b
				WHERE a.emp_no = b.emp_no
                AND b.to_date = '9999-01-01'
                AND CONCAT(a.first_name, ' ', a.last_name) = 'Fai Bale');
                
-- 3-1) 단앨행 연산자: =, >, <, >=, <=, <>, !=
-- 실습문제1
-- 현재, 전체 사원의 평균 연봉보다 적은 급여를 받는 사원의 이름과 급여를 출력 하세요.
SELECT avg(salary)
FROM salaries
WHERE to_date = '9999-01-01';

SELECT a.first_name, b.salary
FROM employees a, salaries b
WHERE a.emp_no = b.emp_no
AND b.to_date = '9999-01-01'
AND b.salary < (SELECT avg(salary)
				FROM salaries
				WHERE to_date = '9999-01-01')
-- 검증
ORDER BY b.salary DESC;

-- 실습문제2
-- 현재, 직책별 평균급여 중에 가장 작은 직책 이름과 그 평균급여를 출력해 보세요.
SELECT a.title, avg(b.salary)
FROM titles a, salaries b
WHERE a.emp_no = b.emp_no
AND a.to_date = '9999-01-01'
AND b.to_date = '9999-01-01'
GROUP BY a.title
LIMIT 1;

SELECT a.title as '직책이름', avg(b.salary) as '평균급여'
FROM titles a, salaries b
WHERE a.emp_no = b.emp_no
AND a.to_date = '9999-01-01'
AND b.to_date = '9999-01-01'
GROUP BY a.title
HAVING avg(b.salary) = (SELECT avg(b.salary)
					FROM titles a, salaries b
					WHERE a.emp_no = b.emp_no
					AND a.to_date = '9999-01-01'
					AND b.to_date = '9999-01-01'
					GROUP BY a.title
					LIMIT 0, 1);
-- limit: index, 개수
                    
--
--
--

-- 2)
SELECT a.title, avg(b.salary)
FROM titles a, salaries b
WHERE a.emp_no = b.emp_no
AND a.to_date = '9999-01-01'
AND b.to_date = '9999-01-01'
GROUP BY a.title;

SELECT min(avg_sal)
FROM (SELECT a.title, avg(b.salary) as avg_sal
	  FROM titles a, salaries b
	  WHERE a.emp_no = b.emp_no
	  AND a.to_date = '9999-01-01'
	  AND b.to_date = '9999-01-01'
	  GROUP BY a.title) a;

--
--
--
      
-- 3)  sol1: where절 subquery(=)
SELECT a.title, avg(b.salary)
FROM titles a, salaries b
WHERE a.emp_no = b.emp_no
AND a.to_date = '9999-01-01'
AND b.to_date = '9999-01-01'
GROUP BY a.title
HAVING avg(b.salary) = (SELECT min(avg_sal)
						FROM (SELECT a.title, avg(b.salary) as avg_sal
						FROM titles a, salaries b
						WHERE a.emp_no = b.emp_no
						AND a.to_date = '9999-01-01'
						AND b.to_date = '9999-01-01'
						GROUP BY a.title) a);

-- 3-2) 복수행 연산자: in, not in, 비교연산자any, 비교연산자all

-- any 사용법
-- 1. =any: in
-- 2. >any, >=any: 최소값
-- 3. <any, <=any: 최대값
-- 4. <>any, !=any: not in

-- all 사용법
-- 1. =all: (x)
-- 2. >all, a>=a;
-- 3. <all, <=all: 최소값
-- 4. <>all, !=all

-- 실습문제3
-- 현재 급여가 50000 이상인 직원의 이름과 급여를 출력하세요
-- 둘리 6000
-- 또치 8000

-- sol1) join
SELECT a.first_name, b.salary
FROM employees a, salaries b
WHERE a.emp_no = b.emp_no
AND b.to_date = '9999-01-01'
AND b.salary > 50000
ORDER BY b.salary;

-- sol2) subquery: where(in)
SELECT emp_no, salary
FROM salaries
WHERE salary > 50000
AND to_date = '9999-01-01';

SELECT a.first_name, b.salary
FROM employees a, salaries b
WHERE a.emp_no = b.emp_no
AND to_date = '9999-01-01'
AND (a.emp_no, b.salary) in (SELECT emp_no, salary
							 FROM salaries
							 WHERE salary > 50000
							 AND to_date = '9999-01-01')
ORDER BY b.salary;

-- sol3) subquey: where(any)


-- 실습문제4:
-- 현재, 각 부서별로 최고 급여를 받고 있는 직원의 부서, 이름과 월급을 출력하세요.
SELECT max(b.salary), a.dept_no
FROM dept_emp a, salaries b
WHERE a.emp_no = b.emp_no
AND a.to_date = '9999-01-01'
AND b.to_date = '9999-01-01'
GROUP BY a.dept_no;

-- sol1: where 절 subquery(in)
SELECT d.dept_name as '부서',  a.first_name as '이름', b.salary as '월급'
FROM employees a, salaries b, dept_emp c, departments d
WHERE a.emp_no = b.emp_no
AND b.emp_no = c.emp_no
AND c.dept_no = d.dept_no
AND b.to_date = '9999-01-01'
AND c.to_date = '9999-01-01'
AND (b.salary, c.dept_no) in (SELECT max(b.salary), a.dept_no
							  FROM dept_emp a, salaries b
							  WHERE a.emp_no = b.emp_no
							  AND a.to_date = '9999-01-01'
							  AND b.to_date = '9999-01-01'
							  GROUP BY a.dept_no);

-- sol2: from절 subquery & join
SELECT a.dept_name as '부서',  c.first_name as '이름', d.salary as '월급'
FROM departments a, dept_emp b, employees c, salaries d,
	(SELECT max(b.salary) as max_sal, a.dept_no
	 FROM dept_emp a, salaries b
	 WHERE a.emp_no = b.emp_no
	 AND a.to_date = '9999-01-01'
	 AND b.to_date = '9999-01-01'
	 GROUP BY a.dept_no) e
WHERE a.dept_no = b.dept_no
AND b.emp_no = c.emp_no
AND c.emp_no = d.emp_no
AND b.dept_no = e.dept_no
AND b.to_date = '9999-01-01'
AND d.to_date = '9999-01-01'
AND d.salary = e.max_sal;


INSERT INTO board VALUES(null, (SELECT max(group_no) + 1 FROM board));

SELECT (SELECT 1+2 FROM dual) FROM dual;

SELECT a.* FROM (SELECT 1+2 FROM dual) a;