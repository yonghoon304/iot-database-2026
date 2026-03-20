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

INSERT INTO accounts (id,owner,balance)
VALUES (4,'park',60000);

SELECT id,owner,balance,fnc_balanceGrade(balance)
  FROM accounts ;

# 함수 원형
# 책 가격별 이윤계산 함수
CREATE FUNCTION madangdb.fnc_interest(
	price int
)
RETURNS INT
BEGIN
	# 변수 선언
	declare myinterest int;
	# 가격이 30000원 이상이면 10%,그 미만은 5% 이윤남김
	
	IF price >=30000 THEN
		SET myinterest = price*0.1;
	ELSE 
		SET myinterest = price*0.05;
	
	END IF;
	
	RETURN myinterest;
	
END

# 함수 원형
CREATE FUNCTION madangdb.fnc_balanceGrade(
	balance int
)
RETURNS varchar(20)
deterministic
BEGIN
	DECLARE grade varchar(20);
	
	IF balance >= 50000 THEN
		SET grade = 'VIP';
	ELSEIF balance >= 20000 THEN
		SET grade = 'gold';
	ELSE 
		SET grade = 'siver';
	END IF;
	RETURN grade;
END