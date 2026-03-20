# 관리자로 실행
# 함수 안정성 체크 안함
SET GLOBAL log_bin_trust_function_creators = 1;

# 함수 사용
SELECT o.custid 
	 , o.orderid 
	 , o.saleprice 
	 , fnc_interest(o.saleprice) AS "이윤"
	 , o.orderdate 
  FROM Orders o;

