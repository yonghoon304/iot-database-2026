# 1번

SELECT c.custid
 	 , sum(o.saleprice ) AS "총_구매금액"
  FROM Customer c
  JOIN Orders o 
    ON c.custid =o.custid
 GROUP BY c.custid
 ORDER BY 총_구매금액 DESC;

# 1번 강사 풀이
SELECT o.custid,sum(o.saleprice) AS  "총"
  FROM Orders o 
 GROUP BY o.custid 
 ORDER BY 총 DESC;
# 2번
SELECT c.name
     , b.bookid 
     , b.price 
     ,o.orderdate 
  FROM Orders o 
  JOIN Book b 
    ON o.bookid =b.bookid 
  JOIN Customer c 
    ON o.custid =c.custid
 ORDER BY o.orderdate DESC,c.name ASC,price DESC;

# 2번 강사 풀이
SELECT c.name,o.bookid,o.saleprice,o.orderdate 
  FROM Customer c 
  JOIN Orders o 
    ON c.custid =o.custid 
 ORDER BY o.orderdate  DESC;
  
# 3번
SELECT o.orderid 
     , o.custid 
     , o.bookid 
     , o.saleprice 
  FROM Orders o 
 WHERE o.saleprice >(
 	SELECT avg(o2.saleprice)
 	  FROM Orders o2)
 ORDER BY o.saleprice DESC;
 
# 3번 강사 풀이
SELECT o.orderid 
     , o.custid 
     , o.bookid 
     , o.saleprice 
  FROM Orders o 
 WHERE o.saleprice >(SELECT avg(saleprice)
  						FROM Orders)
ORDER BY o.saleprice DESC;

# 4번
SELECT c.name
	 , sum(o.saleprice) AS "총_구매금액"
  FROM Customer c 
  JOIN Orders o
    ON c.custid =o.custid 
 GROUP BY c.custid ,c.name 
HAVING 총_구매금액 >=50000
 ORDER BY 총_구매금액 DESC;
 
# 4번 강사 풀이
SELECT c.name
     , t.합
  FROM Customer c 
  JOIN (SELECT custid,sum(saleprice) AS "합"
  			FROM Orders
 			GROUP BY custid
 			HAVING 합 >=50000)t
 	ON c.custid = t.custid
 ORDER BY t.합 DESC;
 


  
 
    
    
    
    
    
    
    
    
    