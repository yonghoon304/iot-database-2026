# CREATE 계속

DROP TABLE NewBook;

# NewBook,NewOrder 테이블 생성
CREATE TABLE NewBook(
	bookid INTEGER PRIMARY KEY,
	bookname varchar(40) NOT NULL,
	publisher varchar(40),
	price decimal(10,2) DEFAULT 10000
	);
# NewCustomer 테이블
CREATE TABLE NewCustomer(
	custid integer,
	custname varchar(40),
	address varchar(120) NOT NULL,
	phone varchar(20) NOT NULL,
	PRIMARY KEY(custid)
	);

# NewOrder 테이블
# 주문번호(PK),고객번호(FK),책번호(FK),
# 판매가격,판매일자
CREATE TABLE NEWOrder(
	orderid integer,
	custid integer NOT NULL,
	bookid integer, # 기본이  null
	salepirce decimal(10,2),
	orderdate datetime,
	PRIMARY key(orderid),
	FOREIGN key(custid) REFERENCES NewCustomer(custid) ON DELETE CASCADE,
	FOREIGN key(bookid) REFERENCES NewBook(bookid) ON DELETE CASCADE
	);

# oldbook
CREATE TABLE OldBook(
	bookid integer PRIMARY KEY AUTO_INCREMENT,
	bookname varchar(40) NOT NULL,
	publisher varchar(40),
	price decimal(10,2)
	);
#bookid는 생략, auto_increment라서 자동 증가시켜줌
INSERT INTO OldBook (bookname,publisher,price)
VALUES ('프로젝트 헤일메리','대한미디어',22000);

# 데이터베이스 생성
# 관리에서 가능!
CREATE DATABASE testdb;

# 사용자 생성,뷰,인덱스 나중에

