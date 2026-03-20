# 동시성 제어(Concurrency Control)

# 테이블 수정
ALTER TABLE accounts 
MODIFY owner varchar(40) NOT NULL,
MODIFY balance int NOT NULL;

truncate TABLE accounts;

SELECT * FROM accounts;

# 새로 데이터 입력
INSERT INTO accounts(id,owner,balance)
values(1,'KIM',10000),(2,'Lee',20000),(3,'choi',3000000);

# 기본 락 실행
# 세션 1번
# START TRANSACTION;

UPDATE accounts
   SET balance = balance + 2000
 WHERE id =2;

SELECT * FROM accounts;

ROLLBACK;
COMMIT;

# Non-Repeatable Read
# 격리수준 하강
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;


SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

# phantom read
# 테이블 생성
CREATE TABLE employees(
	id int PRIMARY KEY AUTO_INCREMENT,
	name varchar(50),
	salary int
);

INSERT INTO employees (name,salary)
VALUES ('용훈',3000),('Bread',4000),('abs',6000);

SELECT * FROM employees;

ROLLBACK;
COMMIT;

# 팬텀 리드 세션 1
# 격리수준 하강
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

SELECT * FROM employees WHERE salary >=5000;

# Deadlock
# autocommit 해제
SELECT @@autocommit;
SET autocommit =0;
COMMIT;

# 2번 id 1000원 차감
update accounts
   set balance = 8000
 where id =5; 

SELECT * FROM accounts;

# 테이블 락
COMMIT;
LOCK tables accounts WRITE;
LOCK tables accounts read; # 읽기 가능 테이블락


SELECT * FROM accounts;
UPDATE accounts
   SET balance = 9000
 WHERE id =3;

UNLOCK tables;