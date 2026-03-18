# 내장함수

# 수학함수
SELECT abs(-78),abs(+78);
  FROM DUAL; # 테이블을 사용하지 않을 때 사용하는 키워드(Oracle 문법)
  
# 반올림
SELECT round(3.141592,3);

# 고객별 평균 주문금액을 백원단위로 반올림하시오
SELECT o.custid AS "고객번호"
     , round(sum(saleprice)/count(*),-2) AS "평균금액"
  FROM Orders o
 GROUP BY o.custid;

SELECT ceil(3.14),floor(3.67),power(2,10);

# 2. 문자함수