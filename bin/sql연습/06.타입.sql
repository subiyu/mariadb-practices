-- cast
SELECT '12345' + 10, cast('12345' as int) + 10 FROM dual;
SELECT date_format(cast('2013-01-09' as date), '%Y년 %m월 %d일') FROM dual;
SELECT cast(1-2 as unsigned) as signend) FROM dual;
SELECT cast(1-2 as unsigned) as int) FROM dual;
SELECT cast(1-2 as unsigned) as integer) FROM dual;

-- type
-- 문자: varchar, char, text, CLOB(Character Large OBject)
-- 정수: medium int, int(signed, integer), unsinged, big int
-- 실수: float, datetime
-- LOB: CLOB, BLOB(Large OBject)