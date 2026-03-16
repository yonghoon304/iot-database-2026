# 1. 도서번호가 1인 도서의 이름
SELECT bookname 
  FROM Book
 WHERE bookid=1;

# 2. 가격이 20000원 이상인 도서의 이름
SELECT b.bookname  
  FROM Book b
 WHERE b.price >=20000
 
 # 3. 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
SELECT sum(o.saleprice )
  FROM Orders o
 WHERE o.custid =1
 
 # 4. 박지성이 구매한 도서의 수
 SELECT sum(o.bookid )
  FROM Orders o
 WHERE o.custid =1
 
 # 5. 마당서점 도서의 총 개수
 SELECT count(*)
   FROM Book;
 
 # 6. 마당서점에 도서를 출고하는 출판사의 총 개수
 SELECT count(b.publisher )
   FROM Book b;
 
 # 7. 모든 고객의 이름,주소
 SELECT c.name 
      , c.address 
   FROM Customer c;
 
 # 8. 2024년7월4일~7월7일 사이에 주문 받은 도서의 주문번호
 SELECT o.orderid  
   FROM Orders o
  WHERE o.orderdate >= '2024-07-04'
    and o.orderdate < '2024-07-08';
 
 # 9. 2024년 7월4일~7월7일 사이에 주문받은 도서를 제외한 도서의 주문번호
 SELECT o.orderdate   
   FROM Orders o
  WHERE o.orderdate NOT BETWEEN '2024-07-04' AND '2024-07-07';
 
 # 성이 김씨인 고객의 이름과 주소
 SELECT c.name ,c.address 
   FROM Customer c
  WHERE c.name LIKE '김%';
 
 # 성이 김씨이고 이름이 아로 끝나는 고객의 이름과 주소
  SELECT c.name ,c.address 
   FROM Customer c
  WHERE c.name LIKE '김%아';
 