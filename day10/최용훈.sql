# 1번 현재 대여 중인 도서를 조회하시오
SELECT m.member_name  AS "회원명"
     , b.book_name AS "책제목"
     , r.rentalDate AS "대여일"
  FROM books b
  JOIN rentals r 
 	ON b.book_idx = r.book_idx
  JOIN members m 
    ON r.member_idx  =m.member_idx
 WHERE r.returnDate IS NULL;
  

# 2번 회원별 대여 횟수를 집계하시오
SELECT m.member_idx AS "회원번호"
	 , m.member_name AS "회원명"
     , count(r.rentalDate) AS "대여횟수"
  FROM members m
  JOIN rentals r 
    ON m.member_idx =r.member_idx
 GROUP BY m.member_name ,m.member_idx
 ORDER BY count(r.rentalDate) DESC, 회원명 ASC;
 
# 3번 장르별 도서수를 조회하시오.
SELECT d.div_code AS "장르코드"
	 , d.div_name AS "장르명"
	 , count(b.book_idx ) AS "도서수"
  FROM books b
 right OUTER JOIN division d 
    ON b.div_code = d.div_code
 GROUP BY d.div_name,d.div_code ;

# 4번 한번도 대여되지 않은 도서를 조회하시오
SELECT *
  FROM books b 
  LEFT OUTER JOIN rentals r 
    ON b.book_idx =r.book_idx 
 WHERE r.rentalDate IS null;

# 5번 평균 대여수보다 많이 대여한 회원을 조회하시오
SELECT m.member_idx AS "회원번호"
     , m.member_name AS "회원명"
     , count(*) AS "대여횟수"
  FROM members m 
  JOIN rentals r 
    ON m.member_idx =r.member_idx 
 GROUP BY m.member_idx 
HAVING count(*)>(
		SELECT avg(t.cnt)
		  FROM (
		  		SELECT count(*) AS "cnt"
				  FROM members m 
  				  JOIN rentals r 
    				ON m.member_idx =r.member_idx 
 			     GROUP BY m.member_idx)t
 			     );


