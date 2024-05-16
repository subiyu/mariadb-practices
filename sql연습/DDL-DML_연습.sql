-- DDL/DML 연습

CREATE TABLE member(
	no int not null auto_increment,
	email VARCHAR(200) not null default '',
    password VARCHAR(64) not null,
    name VARCHAR(50) not null,
    department VARCHAR(100),
	primary key(no)
);
desc member;

ALTER TABLE member ADD COLUMN juminbunho char(13) not null;

ALTER TABLE member DROP juminbunho;

ALTER TABLE member ADD COLUMN juminbunho char(13) not null after email;

ALTER TABLE member CHANGE department dept VARCHAR(100) not null;

ALTER TABLE member add column self_intro text;
desc member;

ALTER TABLE member DROP juminbunho;

-- insert
INSERT INTO member(no, email, name, dept, password)
VALUES (null, 'syu2@gmail.com', '유수빈2', '개발팀2', password('1234'));

INSERT INTO member VALUES (null, 'syu@gmail.com', password('1234'), '유수빈', '개발팀', null);
SELECT * FROM member;

-- update
UPDATE member SET email='syu3@gmail.com', password=password('4321')
WHERE no = 2; 
SELECT * FROM member;

-- delete
DELETE FROM member
WHERE no = 2;
SELECT * FROM member;

-- transaction
SELECT no, email FROM member;

SELECT @@autocommit; -- 1

INSERT INTO member(no, email, name, dept, password)
	   VALUES (null, 'syu3@gmail.com', '유수빈3', '개발팀3', password('1234'));
       
-- tx begin
SET autocommit = 0;
SELECT @@autocommit; -- 0


-- tx end
commit;
SELECT no, email FROM member;