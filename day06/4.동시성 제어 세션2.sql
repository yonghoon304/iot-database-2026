# 세션 2번
UPDATE accounts
   SET balance = balance - 5000
 WHERE id =2;

# start TRANSACTION;
 SELECT * FROM accounts;

 select @@autocommit;
 set autocommit =0;

 commit;

 UPDATE accounts
   SET balance = balance - 50000
 WHERE id =3;

 UPDATE accounts
   SET balance = balance - 5000
 WHERE id =2;

 # Non-Repeatable Read
# 격리수준 하강
SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

select balance From accounts where id =1;

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

# Phantom Read 세션 2
insert into employees (name,salary) values('유림',7000);

commit;

# Deadlock
SELECT @@autocommit;
SET autocommit =0;

select *from accounts;

# 1번 id 계좌금액 1000원 차감 업데이트
update accounts
   set balance = 8000
 where id =6; 

 SELECT * FROM accounts;