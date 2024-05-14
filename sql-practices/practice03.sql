-- 테이블간 조인(JOIN) SQL 문제입니다.

-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
SELECT A.emp_no as '사번', concat(A.first_name, ' ', A.last_name) as '이름', B.salary
FROM employees A
LEFT JOIN salaries B ON A.emp_no = B.emp_no
AND B.to_date = '9999-01-01'
ORDER BY B.salary DESC;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
SELECT A.emp_no as '사번', concat(A.first_name, ' ', A.last_name) as '이름', B.title as '직책'
FROM employees A
LEFT JOIN titles B
ON A.emp_no = B.emp_no
WHERE B.to_date = '9999-01-01';

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.
SELECT C.emp_no as '사번', concat(C.first_name, ' ', C.last_name) as '이름', A.dept_name as '부서'
FROM departments A
LEFT JOIN dept_emp B ON A.dept_no = B.dept_no
LEFT JOIN employees C ON B.emp_no = C.emp_no
WHERE B.to_date = '9999-01-01';

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
SELECT C.emp_no as '사번', concat(C.first_name, ' ', C.last_name) as '이름', E.salary as '연봉', D.title as '직책', A.dept_name as '부서'
FROM departments A, dept_emp B, employees C, titles D, salaries E
WHERE A.dept_no = B.dept_no
AND B.emp_no = C.emp_no
AND C.emp_no = D.emp_no
AND C.emp_no = E.emp_no;

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. 
-- (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 
-- 이름은 first_name과 last_name을 합쳐 출력 합니다.
SELECT A.emp_no as '직책', concat(A.first_name, ' ', A.last_name) as '이름'
FROM employees A, titles B
WHERE A.emp_no = B.emp_no
AND B.title = 'Technique Leader'
AND B.to_date != '9999-01-01';

-- 문제6.
-- 직원 이름(last_name) 중에서 S로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
SELECT C.last_name as '이름', A.dept_name as '부서명', D.title as '직책'
FROM departments A, dept_emp B, employees C, titles D
WHERE A.dept_no = B.dept_no
AND B.emp_no = C.emp_no
AND C.emp_no = D.emp_no
AND C.last_name LIKE 'S%'; 

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을
-- 급여가 큰 순서대로 출력하세요.
-- projection: 사번 이름(first_name) 급여 타이틀
SELECT C.emp_no as '사번', C.first_name '이름', A.salary as '급여', B.title as '타이틀'
FROM salaries A, titles B, employees C
WHERE A.emp_no = B.emp_no
AND B.emp_no = C.emp_no
AND B.title = 'Engineer'
AND A.salary >= 40000
AND A.to_date = '9999-01-01'
AND B.to_date = '9999-01-01'
ORDER BY A.salary DESC;

-- 문제8.
-- 현재 평균급여가 50000이 넘는 직책을 직책, 평균급여로 평균급여가 큰 순서대로 출력하시오
SELECT B.title as '직책', avg(A.salary) as '평균급여'
FROM salaries A, titles B
WHERE A.emp_no = B.emp_no
AND A.to_date = '9999-01-01'
AND B.to_date = '9999-01-01'
GROUP BY B.title
HAVING avg(A.salary) > 50000
ORDER BY avg(A.salary) DESC;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
-- projection: 부서명 평균연봉
SELECT A.dept_name as '부서명', avg(C.salary) as '평균연봉'
FROM departments A, dept_emp B, salaries C
WHERE A.dept_no = B.dept_no
AND B.emp_no = C.emp_no
AND B.to_date = '9999-01-01'
AND C.to_date = '9999-01-01'
GROUP BY A.dept_name
ORDER BY avg(C.salary) DESC;

-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
-- projection: 직책명 평균연봉
SELECT A.title as '직책명', avg(B.salary) as '평균연봉'
FROM titles A, salaries B
WHERE A.emp_no = B.emp_no
GROUP BY A.title
ORDER BY avg(B.salary) DESC;