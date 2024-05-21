--
-- select 연습
--

-- 예제1: departments 테이블의 모든 데이터를 출력
SELECT * FROM departments;

-- 프로젝션(projection)
-- 예제2: : employees 테이블에서 직원의 이름, 성별, 입사일을 출력
SELECT first_name, gender, hire_date
FROM employees;
-- FROM employees limit 0, 5;

-- as(alias, 생략 가능)
-- 예제3: employees 테이블에서 직원의 이름, 성별 입사일을 출력
SELECT first_name as '이름',
       gender as '성별',
       hire_date as '입사일'
FROM employees;

-- distinct
-- 예제4: titles 테이블에서 모든 직급의 이름 출력
SELECT title
FROM titles;

SELECT concat(first_name, ' ', last_name) as '이름',
	   gender as '성별',
       hire_date as '입사일'
FROM employees;

-- 예제4: titles 테이블에서 직급은 어떤 것들이 있는지 직급 이름을 한 번씩만 출력
SELECT distinct(title)
FROM titles;

--
-- where
--

-- 비교연산자
-- 예제1 : employees 테이블에서 1991년 이전에 입사한 직원의
-- 		  이름, 성별, 입사일을 출력
SELECT concat(first_name, ' ', last_name) as '이름',
	   gender as '성별',
       hire_date as '입사일'
FROM employees
WHERE hire_date < '1991-01-01';

-- 논리연산자
-- 예제2: employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 입사일을 출력
SELECT concat(first_name, ' ', last_name) as '이름',
	   gender as '성별',
       hire_date as '입사일'
FROM employees
WHERE hire_date < '1989-01-01'
and gender = 'F';

-- in 연산자
-- 예제3: dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의
-- 		 사번, 부서번호 출력
SELECT emo_no, dept_no
FROM dept_emp
WHERE dept_no = 'd005'
OR dept_no = 'd009';

SELECT emo_no, dept_no
FROM dept_emp
WHERE dept_no in ('d005', 'd009');

-- Like 검색
-- 예제4: employees 테이블에서 1989년에 입사한 직원의 이름, 입사일을 출력
SELECT first_name, hire_date
FROM employees
-- WHERE hire_date LIKE '1989-%';
WHERE hire_date BETWEEN '1989-01-01' and '1989-12-31';

--
-- order by c1 asc, c2
-- 

-- 예제1: employees 테이블에서 직원의 전체이름, 성별, 입사일을 입사일 순으로 출력
SELECT concat(first_name, ' ', last_name) as '이름',
	   gender as '성별',
       hire_date as '입사일'
FROM employees
ORDER BY hire_date asc;

-- 예제2: salaries 테이블에서 2001년의 월급이 가장 높은 순으로 사번, 월급을 출력
SELECT emp_no, salary
FROM salaries
WHERE from_date like '2001-%'
or from_date like '2001%'
ORDER BY salary desc;

-- 예제 3: 남자 직원의 이름, 성별, 입사일을 입사일순(선입순)으로 출력
select first_name, gender, hire_date
from employees
where gender ='m'
order by hire_date asc;

-- 예제 4: 직원의 사번, 월급을 사번(asc), 월급(desc) 
select emp_no, salary
from salaries
order by emp_no asc, salary desc;
