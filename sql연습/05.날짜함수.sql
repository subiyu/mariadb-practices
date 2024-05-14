--
-- 날짜 함수
--

-- curdate(), current_date
SELECT curdate(), current_date FROM dual;

-- curtime(), current_time
SELECT curtime(), current_time FROM dual;

-- now() vs sysdate()
SELECT now(), sysdate() FROM dual;
SELECT now(), sleep(2), now() FROM dual;
SELECT now(), sleep(2), sysdate() FROM dual; -- sysdate()는 시작될 시점의 시간

-- date_fromat
-- default format: %Y-%m-%d %h:%i:%s
SELECT date_format(now(), '%Y년 %m월 %d일 %h시 %i분 %s초') FROM dual;
SELECT date_format(now(), '%d %b \ %y %h:%i%s') FROM dual;

-- period_diff
-- 예제) 근무개월
-- 		포맷팅: YYMM, YYYYMM
SELECT first_name, 
	   hire_date,
       period_diff(date_format(curdate(), '%y%m'), date_format(hire_date, '%y%m')) as Month
FROM employees;

-- date_add(=adddate), date_sub(subdate)
-- 날짜를 date 타입의 컬럼이나 값에 type(year, month, day)의 표현식으로 더하거나 뺄 수 있다.
-- 예제) 각 사원의 근속 연수가 5년이 되는 날에 휴가를 보내준다면 각 사원의 5년 근속 휴가 날짜는?
SELECT first_name,
	   hire_date,
       date_add(hire_date, interval 5 year)
FROM employees;

-- cast
SELECT '12345' + 10, cast('12345' as int) + 10 FROM dual;
SELECT date_format(cast('2013-01-09' as date), '%Y년 %m월 %d일') FROM dual;
SELECT cast(1-2 as unsigned) as signend) FROM dual;
SELECT cast(1-2 as unsigned) as int) FROM dual;
SELECT cast(1-2 as unsigned) as integer) FROM dual;