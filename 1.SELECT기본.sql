use madangdb;
# 일반 조회 쿼리
select * from Book;

# 1 김연아 고객의 전화를 찾으시오
select  phone from Customer 
where name="김연아"  ;
# 기본주석
/*  여러줄
	 주석*/
     
# 테이블에서 가져오는 데이터가 아니면 FROM 절 생략
select now();

# 열 명시
select bookname,price
	from Book;
    
    