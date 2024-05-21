--
-- inner join
--

-- 예제1) 현재, 근무하고 있는 직원의 이름과 직책을 모두 출력하세요.
SELECT a.first_name, b.title
FROM employees a, titles b
WHERE a.emp_no = b.emp_no		-- join 조건(n-1)
AND b.to_date = '9999-01-01';   -- row 선택 조건

-- 예제2) 햔재, 근무하고 있는 직원의 이름과 직책을 모두 출력하되, 여성 엔지니어(Engineer)만 출력하세요.
SELECT a.first_name, b.title
FROM employees a, titles b
WHERE a.emp_no = b.emp_no
AND b.to_date = '9999-01-01'
AND a.gender = 'F'
AND b.title = 'Engineer';

--
-- ANSI/ISO SQL1999 Join 표준문법
-- 

-- 1) natural join
--    조인 대상이 되는 두 테이블에 이름이 같은 공통 컬럼이 있으면
-- 	  조인 조건을 명시하지 않고도 암묵적으로 조인이 된다.
SELECT A.first_name, B.title
FROM employees A NATURAL JOIN titles B
WHERE B.to_date = '9999-01-01';

-- 2) join ~ using
-- 	  natural join 문제점
SELECT *
FROM salaries A JOIN titles B using(emp_no)
WHERE A.to_date = '9999-01-01'
AND B.to_date = '9999-01-01';


-- 3) join ~ on
-- 예제) 현재, 직책별 평균 연봉을 큰 순서대로 출력 하세요.
SELECT A.title, avg(B.salary)
FROM titles A
JOIN salaries B ON A.emp_no = B.emp_no
WHERE A.to_date = '1999-01-01'
AND B.to_date = '1999-01-01'
GROUP BY A.title
ORDER BY avg(B.salary) DESC;


-- 실습문제1
-- 현재, 직원별 근무 부서를 출력해 보세요.
-- 사번, 직원이름(first_name), 부서명 순으로 출력 하세요.
SELECT A.emp_no, A.first_name, C.dept_name
FROM employees A
LEFT JOIN dept_emp B
ON A.emp_no = B.emp_no
LEFT JOIN departments C
ON B.dept_no = C.dept_no
WHERE B.to_date = '9999-01-01';

SELECT A.emp_no, A.first_name, C.dept_name
FROM employees A, departments B, dept_emp C
WHERE A.emp_no = C.emp_no
AND B.dept_no = C.dept_no
AND C.to_date = '9999-01-01';

-- 실습문제 2
-- 현재, 지급되고 있는 급여를 출력해 보세요.
-- 사번, 이름, 급여 순으로 출력
SELECT A.emp_no, A.first_name, B.salary
FROM employees A, salaries B
WHERE A.emp_no = B.emp_no
AND B.to_date = '9999-01-01';

-- 실습문제3
-- 현재, 직책별 평균 연봉과 직원수를 구하되 직원수가 100명 이상인 직책만 출력하세요.
-- projection: 직책 평균연봉 직원수
SELECT A.title, avg(B.salary), count(*)
FROM titles A
LEFT JOIN salaries B ON A.emp_no = B.emp_no
WHERE A.to_date = '9999-01-01'
AND B.to_date = '9999-01-01'
GROUP BY A.title
HAVING count(A.title) >= 100;

-- 실습문제4
-- 현재, 부서별로 직책이 Engineer인 직원들에 대해서만 평균 연봉을 구하세요.
-- projection: 부서이름 평균급여
SELECT A.dept_name, avg(D.salary)
FROM departments A
LEFT JOIN dept_emp B ON A.dept_no = B.dept_no
LEFT JOIN titles C ON B.emp_no = C.emp_no 
LEFT JOIN salaries D ON C.emp_no
WHERE C.title = 'Engineer'
AND B.to_date = '9999-01-01'
AND C.to_date = '9999-01-01'
AND D.to_date = '9999-01-01'
GROUP BY A.dept_no;
