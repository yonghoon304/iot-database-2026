# NULL
# 특수값, 지정되지 않은 값

SELECT NULL +100;

# 전체 레코드를 선택(*)하면 모두가 NULL이 아니기에 갯수 카운팅 가능
# price 컬럼만 카운팅하면 NULL은 카운팅 안됨

# IS NULL,현재 해당 값이 NULL인지 확인
# 1: NULL, 0: NULL이 아님

SELECT *
	 , isnull(phone) AS "NULL"
	 , isnull(name) AS "NULL 아님"
  FROM Customer
 WHERE custid=5;

# NULL이면 값 변환
SELECT *
	 , ifnull(phone,0)
  FROM Customer
 WHERE custid =5;