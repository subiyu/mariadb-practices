select * from user;
delete from user;

select * from book;
delete from book;

select * from cart;
delete from cart;

select * from category;
delete from category;

select * from orders;
delete from orders;

select * from orders_book;
delete from orders_book;


delete from orders_book;
delete from orders;
delete from cart;
delete from book;
delete from category;
delete from user;

SELECT b.book_no, b.user_no, b.quantity, a.title
FROM book a, cart b
WHERE a.no = b.book_no;

SELECT no, user_no, order_number, payment, status, shipping
FROM orders
WHERE no = 10
AND user_no = 23;

SELECT a.book_no, a.order_no, a.quantity, a.price, b.title
FROM orders_book a, book b, orders c, user d
WHERE a.book_no = b.no
AND a.order_no = c.no
AND c.user_no = d.no
AND book_no = 37
AND user_no = 23;

SELECT *
FROM orders_book a, book b, orders c, user d
WHERE a.book_no = b.no
AND a.order_no = c.no
AND c.user_no = d.no;