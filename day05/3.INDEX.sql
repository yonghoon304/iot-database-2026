# 인덱스

# 인덱스 생성요 테이블
# PK 없는 책 테이블
CREATE TABLE Noidx_Book(
	bookid integer,
	bookname varchar(40),
	publisher varchar(40),
	isbn varchar(13),
	releaseyear integer,
	price decimal(8,0)
);

# PK 있는 책 테이블
CREATE TABLE Idx_Book(
	bookid integer,
	bookname varchar(40),
	publisher varchar(40),
	isbn varchar(13),
	releaseyear integer,
	price decimal(8,0),
	PRIMARY key(bookid)
);

# noidx_Book 인덱스 걸기
CREATE UNIQUE INDEX idx_book ON Noidx_Book(bookid);

# PK가 있으면 PK컬럼은 NOT NULL
INSERT INTO Idx_Book VALUES (1,'프로젝트 헤일메리','미디어','9789152468453',2022,18000);
# UNIQUE만 있으면 NULL가능
INSERT INTO Noidx_Book VALUES (null,'프로젝트 헤일메리','미디어','9789152468453',2022,18000);

# PK인덱스가 있는 Idx_Book에 다른 인덱스 생서
CREATE INDEX idx_book_bookname ON Idx_Book(bookname);

# 두 컬럼으로 인덱스
CREATE INDEX idx_book_isbn_releaseyear ON Idx_Book(releaseyear, isbn);

# 인덱스는 삭제후 다시 생성
DROP INDEX idx_book_isbn_releaseyear ON Idx_Book;
CREATE INDEX idx_book_releaseyear_isbn ON Idx_Book(releaseyear, isbn);

# 현재 테이블 상태 분석
ANALYZE TABLE Book;

# 테이블 인덱스 최적화
OPTIMIZE TABLE Book;









