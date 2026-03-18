# ALTER 객체수정

# NewBook 테이블에 ISBN 컬럼을 추가하시오.
ALTER TABLE NewBook 
  ADD isbn char(13);

# 데이터 추가
INSERT INTO NewBook VALUES (
	1,'프로젝트 헤일메리','알에이치',22000,'9788925588735');

SELECT *
  FROM NewBook;

# NewBook테이블에 장르 컬럼을 추가하시오
# 이전에 데이터에 empty가 추가
ALTER TABLE NewBook 
  ADD genre varchar(10) NOT NULL;

# NewBook에 isbn을 삭제하시오.
ALTER TABLE NewBook 
 DROP COLUMN isbn;

# NewBook publisher에 NOT NULL 제약조건을 추가하시오
ALTER TABLE NewBook 
MODIFY publisher varchar(40) NOT NULL;

# 기본키 추가는 alter로 거의 하지 않음
ALTER TABLE NewBook
  ADD PRIMARY key(bookid);

# DROP
DROP TABLE OldBook;

# 관계형 db에서는 관계를 맺고있는 부모테이블 삭제할 수 없음
# 항상 자식 테이블부터 삭제 후 부모테이블 삭제할 수 있음
DROP TABLE NewBook;
DROP TABLE NewCustomer;
#자식부터
DROP TABLE NEWOrder;
DROP TABLE NewBook;
DROP TABLE NewCustomer;