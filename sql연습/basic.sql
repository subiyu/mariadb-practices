select version(), current_date, now() from dual;

-- 수학함수, 사칙연산도 된다.
select sin(pi()/4), 1 + 2 * 3 - 4 / 5 from dual;

-- 대소문자 구분이 없다.
sElect VERSION(), current_DATE, NOW() From DUAL;

-- schema 확인
describe pet;
desc pet;

-- table 삭제
drop table pet;
show tables;

-- table 생성: DDL
create table pet(
	name VARCHAR(100),
    owner VARCHAR(50),
    species VARCHAR(20),
    gender CHAR(1),
    birth DATE,
    death DATE
);

-- insert: DML(C)
insert 
	into pet 
values('성탄이', '안대혁', 'dog', 'm', '2007-12-25', null); 

-- select: DML(R)
select * from pet;

-- update: DML(U)
update pet set name='성타니' where name='성탄이';

-- load data: mysql(CLI) 전용
load data local infile '/root/pet.txt' into table pet;

-- select 연습
select name, species
	from pet
where name='bowser';

select name, species, birth
from pet
where birth >= '1998-01-10';

SELECT name, species, birth
FROM pet
WHERE species = 'dog' OR species = 'snake';

SELECT name, birth
FROM pet
ORDER BY birth desc;

SELECT name, birth, death
FROM pet
WHERE death is not null;

SELECT name, birth
FROM pet
WHERE name like 'b%';

SELECT name
FROM pet
WHERE name like '%fy';

SELECT name
FROM pet
WHERE name like '_____';

SELECT name
FROM pet
WHERE name like 'b____';

SELECT count(*), max(birth)
FROM pet;

select count(death)
FROM pet;