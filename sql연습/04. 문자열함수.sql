--
-- 문자열 함수
--

-- upper(), ucase() -> 문자열 전부 대문자로
select upper('seoul'), ucase('SeouL') from dual;
select upper(first_name) from employees;

-- lower(), lcase() -> 문자열 전부 소문자로
select lower('SEOUL'), lcase('SeoUl') from dual;
select lower(first_name) from employees;

-- substring(문자열, index, length) -> index 위치부터 length 길이 만큼의 substring 출력
select substring('Hello World', 3,2);

-- 예제: 1989년에 집사한 직원들의 이름, 입사일 출력
select first_name, hire_date
from employees
where substring(hire_date,1,4)='1989';

-- lpad -> 왼쪽 정렬 , rpad -> 오른쪽 정렬

select lpad('1234','10','-') from dual;
select rpad('1234','10','-') from dual;

-- 예제) 직원들의 월급을 오른쪽 정렬(빈공간은 *)
select lpad(salary, 10,'*') from salaries;

-- trim, ltrim, rtrim -> 공백제거, 왼쪽 공백제거, 오른쪽 공백제거
select concat("---",ltrim('   hello   '),"---") from dual;
select concat("---",rtrim('   hello   '),"---") from dual;
select concat("---",trim('   hello   '),"---") from dual;
select concat("---",trim(leading 'x' from 'xxxhelloxxx'),"---") from dual; -- 앞쪽 x지움
select concat("---",trim(trailing 'x' from 'xxxhelloxxx'),"---") from dual; -- 뒤쪽 x지움
select concat("---",trim(both 'x' from 'xxxhelloxxx'),"---") from dual; -- 양쪽 x지움

-- length -> 길이
select length("Hello World") from dual;








