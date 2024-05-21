INSERT INTO user(name, email, password, phone) VALUES("데스트유저01", "test01@test.com", "1234", "010-0000-0000");
SELECT * FROM user;
DELETE FROM user WHERE no = 1;

INSERT INTO category(name) VALUES("인문");
SELECT * FROM category;
DELETE FROM category WHERE no = 1;

INSERT INTO book(title, price, category_no) VALUES("과학혁명의 구조", 20000, 1);
SELECT * FROM book;
DELETE FROM book WHERE no = 1;

INSERT INTO cart(user_no, book_no, quantity) VALUES(1, 1, 1);
SELECT * FROM cart;
DELETE FROM cart WHERE book_no = 1;

INSERT INTO orders(user_no, order_number, payment, shipping, status) VALUES(1, "20240520-000012", 82400, "서울시 은평구 진관3로 77 구파발 래미안 926-801", "배송준비");
SELECT * FROM orders;
DELETE FROM orders WHERE no = 4;

INSERT INTO orders_book(order_no, book_no, quantity, price) VALUES(4, 1, 2, 64000);
SELECT * FROM orders;
DELETE FROM orders WHERE no = 2;

