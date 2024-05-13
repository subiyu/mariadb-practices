--
-- 수학함수
--

-- abs(절대값)
select abs(1), abs(-1) from dual;

-- ceil(소수점 올림)
select ceil(3.14), ceiling(3.14) from dual; -- 동일 결과

-- floor(소수점 내림)
select floor(3.14) from dual;

-- mod(나머지)
select mod(10,3), 10%3 from dual; -- 연산자로도 가능

-- round(x) -> x에 가장 근접한 정수
-- round(x,d) -> d는 정밀도, x값 중에 소수점 d 자리에 가장 근접한 실수
select round(1.498), round(1.501) from dual;

select round(1.498,2), round(1.498,3), round(1.498,1), round(1.498,0) from dual;

-- power(x,y), pow(x,y) -> x의 y제곱
select power(2,10), pow(2,10) from dual;

-- sign(x) -> 부호판별, 양수 1, 음수 -1, 0은 0
select sign(5), sign(-5), sign(0);

-- greates(x, y, ...), least(x, y, ...) -> 최댓값 최솟값
select greatest(10, 40, 20, 50), least(10,40,20,50) from dual;
select greatest('b', 'A', 'C', 'D'), least('hello', 'hela', 'hell') from dual;
