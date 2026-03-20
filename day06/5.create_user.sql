# 사용자 생성
CREATE user'dydgns304'@'%' identified BY 'my123456';

# 접속은 가능하지만 선택에 db가 없어서 할 수 있는게 없음

# 사용자 비밀번호 변경
ALTER USER 'dydgns304'@'%' identified BY 'MY123456';

# 사용자 삭제
DROP USER 'dydgns304';

# 권한 부여
GRANT ALL PRIVILEGES ON world.* TO 'dydgns304'@'%';
GRANT ALL PRIVILEGES ON sakila.* TO 'dydgns304'@'%';
GRANT ALL PRIVILEGES ON madangdb.* TO 'dydgns304'@'%';

# 권한 해제
revoke ALL PRIVILEGES ON madangdb.* from 'dydgns304'@'%';
revoke ALL PRIVILEGES ON world.* from 'dydgns304'@'%';
revoke ALL PRIVILEGES ON sakila.* from 'dydgns304'@'%';