# Common Table Expression

# 일반 서브쿼리
/*
SELECT *
  from(SELECT o.custid ,sum(o.saleprice) AS "totalprice"
  FROM Orders o
 GROUP BY o.custid) t
WHERE t.totalprice >31000;
 */

# 구문이 많은 때는 Alt x로 실행권장
WITH order_sum as(
	SELECT o.custid 
	     , sum(o.saleprice) AS "totalprice"
	  FROM Orders o
	 GROUP BY o.custid
 ),
customer_sub AS (
 	SELECT name,address ess
 	  FROM Customer
)
/*
 SELECT *
   FROM order_sum 
  WHERE totalprice >31000;
*/
SELECT *
  FROM customer_sub
 WHERE name = '박지성';

 WITH RECURSIVE numbers AS(
 	SELECT 1 AS num
 	 UNION ALL
 	 
 	SELECT num +1
 	  FROM numbers
 	 WHERE num <10
 )
 SELECT *
   FROM numbers;