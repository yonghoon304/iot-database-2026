# iot-database-2026
2026년 iot개발자 데이터베이스 리포지토리

## 1일차

### 데이터/정보/지식
- `데이터` : 단순한 수치나 값
- `정보` : 데이터의 의미를 부여한 것
- 지식 : 정보를 통한 사물이나 현상에 대한 이해

### 데이터베이스
- 조직에 필요한 정보를 위해서 논리적으로 연관된 데이터를 구조적으로 통합,저장해 놓은 것
- `도메인` - 자기 업무에 관련된 지식
- 기업/기관은 자기 도메인 정보만 저장
- 보통 CS(Client - Server) 프로그램이라고 명칭, DB쪽이 서버, 프로그램쪽이 클라이언트

#### 데이터베이스 개념, 특징

- 통합 데이터 - `데이터 중복 최소화`, 중복으로 인한 데이터 `불일치 현상 제거`
- 저장 데이터 - 문서가 아닌 `컴퓨터 저장장치에 저장`, 반영구적 저장
- 운영 데이터 - 저장된 상태에서 `업무를 위해` 검색,수정 등 사용 가능
- 공용 데이터 - 여러 사람이 업무를 위해 `공동으로 사용`

#### 특징
- 실시간 접근성 - 수 초내 결과가 리턴
- 계속적 변화 - 추가,수정,삭제,조회 가능
- 동시 공유 - 여러 사용자가 동시에 공유, 같은 데이터를 사용하더라도 최대한 문제가 없게 처리
- 내용에 따른 참조 - 물리적인 저장 데이터가 아닌 데이터값을 참조

#### DBMS
- 데이터베이스를 관리하는 시스템 DataBase Managemnt System의 약자
- DBMS를 데이터베이스,DB로 통칭

#### DBMS 장점
- 데이터 중복최소화,데이터 일관성,데이터 독립성,관리기능(백업,복구,`동시성제어`,계정,보안)개발 생산성,`데이터 무결성 유지`,데이터 표준 준수...

### 데이터베이스 설치

#### 로컬 설치
1. https://www.mysql.com/ 사이트 > 다운로드 메뉴
2. MySQL Community Edition 아래 링크 클릭
3. MySQL Installer for Windows 링크 클릭
4. Windows (x86, 32-bit), MSI Installer 500M 이상 파일 다운로드
5. 회원가입이나 로그인 없이 클릭
6.  ![alt text](image.png)
    ![alt text](image-1.png)
    ![alt text](image-2.png)

#### 도커사용 설치
- Docker - 애플리케이션 신속 구축,테스트,서비스할 수 있는 컨테이너 기반의 오픈 소스 가상화 플랫폼
    - 온라인 상에서 이미지를 다운로드(pull)
    - 실행하는 컨테이너로 만듬(run)
- `도커가 뭘까?` - 가상 환경.

1. 도커 설치
    - https://www.docker.com/ download docker desktop / AMD64 설치
    - ![alt text](image-3.png)
    - 재부팅
    - Docker Subscription Service Agreement 창 Accept 클릭
    - Linux 용 window 하위 시스템 설치 필수 , `wsl --update` 실행
    - ![alt text](image-4.png)

2. 도커 설정
    - 설정 > general > Start Docker Desktop when you sign in to your computer 체크

3. 도커 콘솔 명령어
    ```powershell
    > docker
    > docker --version
    > docker search 이미지명
    > docker pull 이미지명
    > docker run ...
    ```

4. MySQL 설치
    - PowerShell 열기
    - docker search는 도커허브를 검색 기능
    ```powershell
    > docker search mysql
    ```

    - docker pull 이미지 다운
    ```powershell
    > docker pull mysql:8.0.45
    ```
    ![alt text](image-5.png)

    - docker run 컨테이너 실행
    - \는 윈도우에서 사용 불가, 여러 줄 명령 불가능
    ```powershell
    >  docker run -d --name mysql80 -p 3306:3306 -e MYSQL_ROOT_PASSWORD=my123456 -e MYSQL_DATABASE=mydb -e MYSQL_USER=myuser -e MYSQL_PASSWORD=my123456 -v mysql80_data:/var/lib/mysql --restart unless-stopped mysql:8.0.45
    ```
    - 필요 계정
        - root(관리자) - my123456
        - myuser(사용자) - my123456

    - 옵션 설명
    - `--name mysql80` : 컨테이너 이름
    - `-p 3306:3306` : 포트번호, (컴퓨터에서 접근하는 포트):(컨테이너 내부 포트)
    - `MYSQL_ROOT_PASSWORD` : Mysql 관리 root계정 비밀번호 초기화
    - `MYSQL_DATABASE=mydb` : 컨테이너 시작시 자동 생성할 DB
    - `MYSQL_USER=myuser` : 일반사용자 계정
    - `mysql80_data:/var/lib/mysql` : 컨테이너 내 mysql 데이터 저장위치
    - `--restart unless-stopped` : 도커 재시작시 자동복구

    - docker ps - 현재 실행중인 컨테이너 확인
    - docker exec - 도커 컨테이너 내부 접속
    ```powershell
    > docker exec -it mysql80 mysql -u root -p
    Enter password
    ```
5. Mysql workbench 설치
    - Database 개발툴,기본툴
    - 로컬에서 다운로드한 MySQL installer 8.0.45.exe 실행
    - MySQL Connections 옆 동그라미+ 아이콘 클릭
    ![alt text](image-6.png)
    ![alt text](image-7.png)

6. DBeaver 개발툴 설치
    - https://dbeaver.io/ 다운로드 > x86.exe
    - 일반적인 프로그램 설치와 동일
    - 대문자 자동변경
    ![alt text](image-10.png)

7. Visual Studio Code DB확장 설치
    - 확장 > Database 검색
    ![alt text](image-9.png)
    - database 아이콘 클릭 > create connection 클릭
    - ![alt text](image-11.png)
    - 연결은 다른 개발툴과 동일

#### MySQL 접속
    - 관리자계정 - root
        - 새 사용자 생성, 새 데이터베이스 생성,권한,백업 및 복구
    - 일반계정 - myuser,madang
        - 해당 데이터베이스에서 데이터 처리 작업

### 기본 이론


#### 관계형 데이터베이스
- Relational Database
    - 1969년 E.F.codd 수학 모델에 근간해서 고안
    - 테이블을 최소단위로 구성
    - 각 테이블간 관계를 통해서 데이터모델을 구성

#### 데이터베이스 종류
- 관계형 데이터베이스
    - Oracle,SQL Server(MS),MySQL(Oracle),MariaDB,PostgreSQL(오픈소스)
- NoSQL 데이터베이스
    - MongoDB,Redis,Apache,Cassandra ...
- In-Memory 데이터베이스
    - SAP HAMA...

#### SQL
- Stuctured Query Language
    - 구조화된 질의 언어
    - 데이터베이스에서 데이터를 조작하고, 테이블과 같은 객체를 컨트롤하는 등의 작업을 수행하는 프로그래밍 언어

- SQL 종류
    - DML(Data Manipulation Language) - 데이터 조작 언어, SELECT,INSERT,UPDATE,DELETE와 같은 데이터를 조작하는 언어
    - DDL(Data Definition Language) - 데이터 정의어, CREATE,ALTER,RENAME,DROP 같은 객체(데이터베이스,테이블,사용자,뷰,인덱스..)를 처리하는 언어.
    - DCL(Data Control Language) - 데이터 제어어, GRANT,REVOKE 와 같이 사용자에게 권한주고 해제하는 기능을 처리하는 언어
    - TCL(Transaction Control Language) - 트랜잭션 제어어, BEGIN TRAN,COMMIT,ROLLBACK 같은 트랜잭션 처리로 동시성 제어를 위한 언어

### SELECT 실습
    - 기본문법
        ```sql
        # 기본 조회 쿼리, * 과 ALL 키워드랑 다름.
        SELECT * 
            FROM 테이블명;
        
        # 컬럼,열 명시할 때
        SELECT col1,col2...coln
             FROM 테이블명;

        # 조건 필터링(필요한 행,레코드)만 조회할 때
        SELECT *|열 이름 나열
            FROM 테이블명
            WHERE 조건...
        
        # 정렬
        # ASC 기본,생략가능
        SELECT *|열 이름 나열
            FROM 테이블명
            (WHERE 조건...)
            ORDER BY 열 나열 ASC|DESC

        ```
 
## 2일차

### 도커 사용하는 이유
- 설치 편의성 - 이미지만 있으면 컨테이너로 실행하는데 수십초에 불과함. 설치설정이 불필요
- 환경격차 문제 해결(사용자들간의 버전 문제를 해결) - OS단의 설정까지 건드려야하는 문제를 없애고, 간단하게 서비스를 실행 가능
- 서버비용 절감 - 새로운 서비스를 할 떄마다 하드웨어 서버를 구매,설정할 필요 없음
- OS에 독립적 - 새로운 서비스의 운영OS에 따라 새로 설치할 필요없음
- 가상머신보다 빠름 - VMWare,VirtualBox와 같은 가상OS 플랫폼보다 실행속도가 빠름. 가상OS에서 필요없는 기능 제거,용량 축소

### AI시대 PostgreSQL 학습
- DB시장에서 Oralce,MySQL,SQLserver 다음 PostgreSQL이 4위
- AI시대에 더 비중이 오름
- 나중에 학습할 것

### DBeaver 접속설정 다시
- public Key Retrieval is not allowed 접속오류 발생시
    - ![alt text](image-12.png) 
    `false -> true` 변경

### SELECT 실습

- 기본문법 [쿼리](./1%20select%20기본%20.sql)
    ```sql
    SELECT ALL|DISTINCT 컬럼1,...
      FROM 테이블명
     WHERE 필터링조건
     GROUP BY 그루핑컬럼1,컬럼2...
    HAVING 집계함수 필터링 조건
     ORDER BY 컬럼1,컬럼2 DESC
    ```
#### 필터링

- WHERE 절 - 전체 데이터에서 필요한 것만 필터링
    - 비교 - =,<>,!=(DB 종류별로 다름),<,>,<=,>=

    - 범위 - BETWEEN (이상)A AND (이하)B, 날짜는 조심할 것
        - price BETWEEN 10000 AND 20000

    - 집합 - IN, NOT IN 
        - price IN (1000,2000,3000) -- 가격이 안에 속하는 데이터
        - price NOT IN (1000,2000,3000) -- 제외한 나머지 데이터

    - 패턴 - LIKE(문자열만),&,_
        - bookname LIKE '축구%' -- 축구로 시작하는 책제목 모두

    - NULL - 데이터가 없는 것, 입력되지 않은 것, =로 비교하지 않음
        - price IS NULL, IS NOT NULL

    - 복합 - AND , OR , NOT
        - (price < 2000) AND (bookname LIKE '축구%') 
    
- ORDER BY  - 정렬 ASC,DESC

#### 별명

- Alias - 별명으로 칼럼명,테이블명 등 원래의 이름을 바꿔쓰고 싶을 때 AS사용
    - " 쌍따옴표로 별명을 지정하는 것을 추천

#### 그룹화 및 집계함수

- GROUP BY - 집계합수, DB를 사용하는 가장 큰 목적 중 하나
    - SUM() : 총합
    - COUNT() : 총 개수, 컬럼 대신 * 가능
    - MAN() : 최대값
    - MIN() : 최소값
    - AVG() : 평균값
    - STD() : 표준편차
    
- HAVING - 일반 필터링은 WHERE절로, 집계함수 필터링은 HAVING절로

- GROUP BY,HAVING `주의사항`
    - GROUP BY에 포함되지 않은 컬럼은 SELECT에 사용할 수 없음
    - 집계함수 외 일반칼럼은 SELECT ,GROUP BY 일치시킬 것
    - HAVING 절에는 집계함수 필터링 포함
    - `WHERE 절에 집계함수 사용불가!`

#### 조인 [쿼리](./day02/Join.sql)

- JOIN - 관계형 DB의 핵심기능
    - 두 개 이상으 테이블을 합쳐서 하나의 테이블처럼 보여주는 기능

- JOIN 종류 - 종류는 많으나 3가지만 알면 됨
    - `INNER JOIN`(내부조인) - 조인 중에서 가장 간단한 조인,컬럼이 일치하는 데이터만 조회, 기준 테이블 없음, 조인되는 테이블 간의 관계 일치
    - OUTER JOIN(외부조인) - 한 테이블 기준으로 데이터가 일치하지않는 데이터까지 나오도록 조회하는 조인
        - `LEFT OUTER JOIN` - 두 개의 테이블 중 앞쪽 테이블 기준
        - `RIGHT OUTER JOIN` - 두 개의 테이블 중 뒤쪽 테이블 기준

#### 서브쿼리(부속질의) [쿼리](./day02/4.SubQuery.sql)
- SubQuery - 쿼리 내부에 포함되는 하위쿼리. 항상(소괄호) 내에 작성
    - 서브쿼리는 괄호 안의 쿼리부터 먼저작성
    - 메인쿼리 - 소괄호 밖의 쿼리
    - 서브쿼리 - 소괄호 안의 쿼리

## 3일차

### SELECT 실습

#### 서브쿼리 계속

#### 집합연산

### DML 기타

#### INSERT

#### UPDATE

#### DELETE

