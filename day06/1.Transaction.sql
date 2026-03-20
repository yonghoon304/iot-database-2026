# 트랜잭션 기본

# 계좌 테이블 생성

CREATE TABLE accounts(
	id int PRIMARY KEY,
	owner varchar(40),
	balance int 
);
# 데이터 추가
INSERT INTO accounts(id,owner,balance)
values(1,'KIM',10000),(2,'Lee',20000),(3,'choi',3000000)

# 트랜잭션 사용가능 여부 확인
# 1이 나오면 자동커밋상태(트랜잰셕 확인 불가)
# 0이 나와야함
SELECT @@autocommit;

# 자동커밋 끄기
SET autocommit =0;

# 트랜잭션 사용순서
START TRANSACTION;


COMMIT;
ROLLBACK;

# 1. Kim 계좌에서 1000원 출금
START TRANSACTION;

UPDATE accounts
   SET balance =balance -1000
 WHERE id=1;

SELECT * FROM accounts;

COMMIT;
ROLLBACK;

# 2. Lee 계좌에서 30000원 출금
START TRANSACTION;

UPDATE accounts
   SET balance =balance -30000
 WHERE id=2;

SELECT * FROM accounts;

COMMIT;
ROLLBACK;

# 3. Kim 계좌에서 choi 5000원 송금
START TRANSACTION;

# kim 출금
UPDATE accounts
   SET balance =balance -5000
 WHERE id=1;
# choi 입금
UPDATE accounts
   SET balance =balance +5000
 WHERE id=3;

SELECT * FROM accounts;

COMMIT;
ROLLBACK;

# 4. kim -> Lee로 송금 중 문제발생
START TRANSACTION;

# kim 출금
UPDATE accounts
   SET balance =balance -5000
 WHERE id=1;

SAVEPOINT sp_transfer;
# Lee 입금
UPDATE accounts
   SET balance =balance +5000
 WHERE id=2;

SELECT * FROM accounts;

ROLLBACK TO sp_transfer;

ROLLBACK;
commit ;

# 현재 MySQL DB엔진 종류확인
# InnoDB(최신버전 엔진),MyISAM(구버전)
# MyISAM 트랜잭션 처리가 필요X
SHOW TABLE status LIKE 'accounts';

# 현재 실행중 트랜잭션 조회 쿼리(root만 가능)
SELECT * FROM information_schema.innodb_trx it;








