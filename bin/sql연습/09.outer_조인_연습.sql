-- outer join

insert into dept values(null, '총무');
insert into dept values(null, '개발');
insert into dept values(null, '영업');
insert into dept values(null, '기획');

delete from dept;

select * from dept;

insert into emp values(null, '둘리', 1);
insert into emp values(null, '마이콜', 2);
insert into emp values(null, '또치', 3);
insert into emp values(null, '길동', null);

select * from emp;

-- inner join
SELECT A.name as '이름', B.name as '부서'
FROM emp A
JOIN dept B ON A.dept_no = B.no;

-- left (outer) join
SELECT A.name as '이름', ifnull(B.name, '없음') as '부서'
FROM emp A
LEFT JOIN dept B ON A.dept_no = B.no;

-- right (outer) join
SELECT ifnull(A.name, '없음') as '이름', B.name as '부서'
FROM emp A
RIGHT JOIN dept B ON A.dept_no = B.no;

-- full (outer) join
SELECT A.name as '이름', ifnull(B.name, '없음') as '부서'
FROM emp A
LEFT JOIN dept B ON A.dept_no = B.no;